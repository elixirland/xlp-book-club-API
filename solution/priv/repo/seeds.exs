import Ecto.Query, only: [from: 2]
alias BookClub.Repo
alias BookClub.Books.{Book, Page}

# Setup
# Sets log level to :info for performance
initial_log_level = Logger.level()
Logger.configure(level: :info)
IO.puts("Start database seeding")
start_time = System.os_time(:millisecond)

# Constants
n_books = 4000
n_pages_per_book = 10
inserted_at = NaiveDateTime.utc_now(:second)
batch_size = 800

# Insert 4,000 books
books =
  for _ <- 1..n_books do
    %{
      title: XlFaker.generate_title(),
      inserted_at: inserted_at,
      updated_at: inserted_at
    }
  end

books
|> Enum.chunk_every(batch_size)
|> Enum.each(&Repo.insert_all(Book, &1))

# Batch insert 10 pages per book
# Gives some books an active page
book_ids =
  from(b in Book, select: b.id)
  |> Repo.all()

pages =
  book_ids
  |> Enum.flat_map(fn book_id ->
    pages =
      for i <- 1..n_pages_per_book do
        %{
          book_id: book_id,
          content: XlFaker.generate_page(),
          number: i,
          status: :inactive,
          inserted_at: inserted_at,
          updated_at: inserted_at
        }
      end

    List.update_at(
      pages,
      :rand.uniform(n_pages_per_book) - 1,
      &Map.put(&1, :status, Enum.random([:active, :inactive]))
    )
  end)

pages
|> Enum.chunk_every(batch_size)
|> Enum.each(&Repo.insert_all(Page, &1))

# Teardown
end_time = System.os_time(:millisecond)
IO.puts("Finish database seeding")
IO.puts("Seeded #{n_books} books in #{end_time - start_time}ms")
Logger.configure(level: initial_log_level)
