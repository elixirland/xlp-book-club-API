defmodule XlPhoenixAPI.Repo.Migrations.AddBooksTable do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string

      timestamps()
    end
  end
end
