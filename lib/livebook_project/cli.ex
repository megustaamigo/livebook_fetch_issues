defmodule LivebookProject.Cli do
  @default_count 5

  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    |> elem(1)
    |> args_to_internal_representation
  end

  def args_to_internal_representation([user, project, count]) when is_float(count) do
    {user, project, round(count)}
  end

  def args_to_internal_representation([user, project, count]) do
    {user, project, String.to_integer(count)}
  end

  def args_to_internal_representation([user, project]) do
    {user, project, @default_count}
  end

  def args_to_internal_representation(_) do
    :help
  end

  def process({user, project, count}) do
    LivebookProject.GithubIssues.fetch(user, project)
    |> decode_response()
    |> sort_into_descending_order()
    |> size_down_list(count)
    |> filter_relevant_fields()
  end

  def into_databse(data) do
    case LivebookProject.MyRepo.start_link() do
      {:ok, _pid} ->
        data
        |> LivebookProject.DataImporter.insert_issues()

      {:error, {:already_started, _pid}} ->
        data
        |> LivebookProject.DataImporter.insert_issues()

      {:error, reason} ->
        IO.puts("Failed to start repo: #{inspect(reason)}")
        System.halt(1)
    end
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    IO.puts("Error fetching from Github: #{error["message"]}")
    System.halt(2)
  end

  def sort_into_descending_order(list_of_issues) do
    list_of_issues
    |> Enum.sort(fn i1, i2 -> i1["number"] >= i2["number1"] end)
  end

  def size_down_list(list_of_issues, count) do
    Enum.take(list_of_issues, count)
  end

  def filter_relevant_fields(list_of_issues) do
    Enum.map(list_of_issues, fn issue ->
      %{
        "title" => issue["title"],
        "number" => issue["number"],
        "state" => issue["state"],
        "issues_updated_at" => issue["updated_at"]
      }
    end)
  end
end
