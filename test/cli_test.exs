defmodule CliTest do
  use ExUnit.Case
  @user "elixir-lang"
  @project "elixir"
  @argv ["elixir-lang", "elixir", "31"]
  @argv_no_count ["elixir-lang", "elixir"]
  @argv_hilfe ["help"]
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
    assert LivebookProject.Cli.args_to_internal_representation(@argv) ==
             {"elixir-lang", "elixir", 31}

    assert LivebookProject.Cli.args_to_internal_representation(@argv_no_count) ==
             {"elixir-lang", "elixir", 5}
  end

  test "internal representation is correct when asked for help" do
    assert LivebookProject.Cli.parse_args(@argv_hilfe) == :help
  end

  test "is the url properly constructed" do
    assert LivebookProject.GithubIssues.construct_url(@user, @project) ==
             "https://api.github.com/repos/elixir-lang/elixir/issues"
  end

  test "status code is 200" do
    assert LivebookProject.GithubIssues.check_for_error(200) == :ok
    assert LivebookProject.GithubIssues.check_for_error(123) == :error
  end

  test "decode the response body  and just return the body" do
    assert LivebookProject.Cli.decode_response(@successful_HTTP_get) == [
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
    list = LivebookProject.Cli.decode_response(@successful_HTTP_get)

    assert LivebookProject.Cli.sort_into_descending_order(list) == [
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
    list =
      LivebookProject.Cli.decode_response(@successful_HTTP_get)
      |> LivebookProject.Cli.sort_into_descending_order()

    assert LivebookProject.Cli.size_down_list(list, 1) == [
             %{"updated_at" => "23-04-2024", "number" => 2, "state" => "open", "title" => "add y"}
           ]
  end
end
