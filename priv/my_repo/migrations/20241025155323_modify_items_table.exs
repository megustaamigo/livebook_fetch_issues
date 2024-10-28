defmodule LivebookProject.MyRepo.Migrations.ModifyItemsTable do
  use Ecto.Migration

  def change do
    create unique_index(:items, [:title])
  end
end
