require Logger
alias BookClub.Repo
alias BookClub.Books.{Book, Page}

# Setup
initial_log_level = Logger.level()
# Comment the next line to not override the log level configuration. The default
# log level in applications generated with `mix phx.server` is `:debug`, which
# produces verbose output.
Logger.configure(level: :info)
Logger.info("Start database seeding")
start_time = System.os_time(:millisecond)

# Clear data
Repo.delete_all(Page)
Repo.delete_all(Book)

# Constants
n_books = 600
n_pages_per_book = 400
inserted_at = ~N[2000-01-01 12:00:00]
batch_size = 100
max_concurrency = 8

# Batch insert books
books =
  for _ <- 1..n_books do
    %{
      title: XlFaker.generate_title(),
      inserted_at: inserted_at,
      updated_at: inserted_at
    }
  end

insert_batch_fn = fn batch -> Repo.insert_all(Book, batch, returning: [:id]) end

book_ids =
  books
  |> Enum.chunk_every(batch_size)
  |> Task.async_stream(insert_batch_fn, max_concurrency: max_concurrency)
  |> Enum.flat_map(fn {:ok, {_, books}} -> books end)
  |> Enum.map(fn %{id: id} -> id end)

# Batch insert multiple pages for each book
# Let some books have an active page
build_book_pages_fn =
  fn book_id ->
    for i <- 1..n_pages_per_book do
      %{
        book_id: book_id,
        number: i,
        status: :inactive,
        content: XlFaker.generate_page(),
        inserted_at: inserted_at,
        updated_at: inserted_at
      }
    end
    |> List.update_at(
      :rand.uniform(n_pages_per_book) - 1,
      &Map.put(&1, :status, Enum.random([:active, :inactive]))
    )
  end

book_ids
|> Enum.flat_map(&build_book_pages_fn.(&1))
|> Enum.chunk_every(batch_size)
|> Task.async_stream(&Repo.insert_all(Page, &1), max_concurrency: max_concurrency)
|> Stream.run()

# Teardown
end_time = System.os_time(:millisecond)
run_time = end_time - start_time
Logger.info("Finish database seeding")
Logger.info("Seeded #{n_books} books and #{n_books * n_pages_per_book} pages in #{run_time}ms")
Logger.configure(level: initial_log_level)
