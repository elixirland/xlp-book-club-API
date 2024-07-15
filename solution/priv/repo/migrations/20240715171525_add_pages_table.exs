defmodule XlPhoenixAPI.Repo.Migrations.AddPagesTable do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :number, :integer, null: false
      add :content, :text, null: false
      add :status, :string, null: false
      add :book_id, references(:books), null: false

      timestamps()
    end

    create unique_index(:pages, [:number, :book_id])
  end
end
