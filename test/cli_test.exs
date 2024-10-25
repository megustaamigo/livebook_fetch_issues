defmodule CliTest do
  use ExUnit.Case
  @user Sam
  @project Test
  @argv_list ["Sam", "Test", "31"]
  @argv_list_no_count ["Sam", "Test"]
  @successful_HTTP_get {:ok,
                        [
                          %{
                            "updated_at" => "22-04-2024",
                            "number" => 1,
                            "state" => "open",
                            "title" => "add x"
                          },
                          %{
                            "updated_at" => "23-04-2024",
                            "number" => 2,
                            "state" => "open",
                            "title" => "add y"
                          }
                        ]}

  @erroneous_HTTP_get {:error, [%{"message" => "22-04-2024"}]}

  test "internal representation is correct" do
    assert Cli.args_to_internal_representation(@argv_list) == {"Sam", "Test", 31}
  end

  test "internal representation is correct when no count is given" do
    assert Cli.args_to_internal_representation(@argv_list_no_count) == {"Sam", "Test", 5}
  end

  test "internal representation is correct when asked for help" do
    argv = ["hilfe"]
    assert Cli.parse_args(argv) == :help
  end

  test "is the url properly constructed" do
    assert GithubIssues.construct_url(@user, @project) ==
             "https://api.github.com/repos/Elixir.Sam/Elixir.Test/issues"
  end

  test "status code is 200" do
    assert GithubIssues.check_for_error(200) == :ok
    assert GithubIssues.check_for_error(123) == :error
  end

  test "decode the response body  and just return the body" do
    assert Cli.decode_response(@successful_HTTP_get) == [
             %{
               "updated_at" => "22-04-2024",
               "number" => 1,
               "state" => "open",
               "title" => "add x"
             },
             %{"updated_at" => "23-04-2024", "number" => 2, "state" => "open", "title" => "add y"}
           ]
  end

  test "sort list of issues into descending order based on date of update" do
    list = Cli.decode_response(@successful_HTTP_get)

    assert Cli.sort_into_descending_order(list) == [
             %{
               "updated_at" => "23-04-2024",
               "number" => 2,
               "state" => "open",
               "title" => "add y"
             },
             %{"updated_at" => "22-04-2024", "number" => 1, "state" => "open", "title" => "add x"}
           ]
  end

  test "reduce the elements in the list based on count" do
    list = Cli.decode_response(@successful_HTTP_get) |> Cli.sort_into_descending_order()

    assert Cli.size_down_list(list, 1) == [
             %{"updated_at" => "23-04-2024", "number" => 2, "state" => "open", "title" => "add y"}
           ]
  end
end
