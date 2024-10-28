defmodule LivebookProject.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field(:title, :string)
    field(:number, :integer)
    field(:state, :string)
    field(:issues_updated_at, :string)
    timestamps()
  end

  def changeset(item, attrs) do
    item
    |> cast(attrs, [:title, :number, :state, :issues_updated_at])
    |> validate_required([:title, :number, :state, :issues_updated_at])
    |> unique_constraint(:title)
  end
end
