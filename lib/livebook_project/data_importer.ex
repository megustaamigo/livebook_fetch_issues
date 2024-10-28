defmodule LivebookProject.DataImporter do
  alias LivebookProject.MyRepo
  alias LivebookProject.Item

  def insert_issues(issues) do
    # Check what you're trying to insert
    IO.inspect(issues, label: "Inserting Issues")

    Enum.each(issues, fn issue ->
      changeset = Item.changeset(%Item{}, issue)

      case MyRepo.insert(changeset) do
        {:ok, _record} ->
          IO.puts("Inserted #{issue["title"]} successfully")

        {:error, changeset} ->
          IO.inspect(changeset.errors, label: "Failed to insert")
      end
    end)
  end
end
