defmodule LivebookProject.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :title, :string
      add :number, :integer
      add :state, :string
      add :issues_updated_at, :string  # Change to :naive_datetime if using datetime

      timestamps()
    end
  end
end
