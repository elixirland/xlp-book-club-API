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

    create unique_index(
             :pages,
             [:book_id, :status],
             where: "status = 'active'",
             name: :max_one_active_page_per_book
           )

    # Trigger that checks if the page numbers of a book form an uninterrupted
    # sequence starting from 1
    # execute("""
    # CREATE OR REPLACE FUNCTION check_page_sequence() RETURNS trigger AS $$
    # DECLARE
    #     last_number INTEGER;
    # BEGIN
    #     SELECT MAX(number) INTO last_number FROM pages WHERE book_id = NEW.book_id AND id != NEW.id;

    #     IF last_number IS NULL THEN
    #         last_number := 0;
    #     END IF;

    #     IF NEW.number != last_number + 1 THEN
    #         RAISE EXCEPTION 'Page number must be % for book_id %, but got %', last_number + 1, NEW.book_id, NEW.number;
    #     END IF;

    #     RETURN NEW;
    # END;
    # $$ LANGUAGE plpgsql;
    # """)

    # execute("""
    # CREATE TRIGGER ensure_page_sequence
    # BEFORE INSERT OR UPDATE ON pages
    # FOR EACH ROW
    # EXECUTE FUNCTION check_page_sequence();
    # """)
  end

  def down do
    # execute("DROP TRIGGER IF EXISTS ensure_page_sequence ON pages")
    # execute("DROP FUNCTION IF EXISTS check_page_sequence")

    drop unique_index(
           :pages,
           [:book_id, :status],
           where: "status = 'active'",
           name: :max_one_active_page_per_book
         )

    drop table(:pages)
  end
end
