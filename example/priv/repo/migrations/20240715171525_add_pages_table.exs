defmodule BookClub.Repo.Migrations.AddPagesTable do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :number, :integer, null: false
      add :content, :text, null: false
      add :status, :string, null: false
      add :book_id, references(:books), null: false

      timestamps()
    end

    # Only one active page per book
    create unique_index(
             :pages,
             [:book_id, :status],
             where: "status = 'active'",
             name: :max_one_active_page_per_book
           )

    # Page number must be 1 or greater
    create constraint(
             :pages,
             :positive_page_number,
             check: "number > 0"
           )

    # Page number must be unique per book
    create unique_index(
             :pages,
             [:book_id, :number],
             name: :unique_page_number_per_book
           )
  end
end
