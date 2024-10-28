defmodule LivebookProject.GithubIssues do
  alias LivebookProject, as: LivebookProject
  @headers [{"User-Agent", "Samuel"}]

  def fetch(user, project) do
    construct_url(user, project)
    |> HTTPoison.get(@headers)
    |> handle_response
  end

  def construct_url(user, project) do
    "https://api.github.com/repos/#{user}/#{project}/issues"
  end

  def handle_response({_, %{status_code: status_code, body: body}}) do
    {status_code |> check_for_error(), body |> Poison.Parser.parse!()}
  end

  def check_for_error(200), do: :ok
  def check_for_error(_), do: :error
end
