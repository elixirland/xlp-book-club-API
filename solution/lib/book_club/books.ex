defmodule BookClub.Books do
  import Ecto.Query, warn: false
  alias BookClub.Repo
  alias BookClub.Books.{Book, Page}

  @type id :: non_neg_integer()

  @doc """
  List books with their active or first page.

  ## Options
  - `:filter` - A string to filter books by their title. Filters by partial match and is case-insensitive.

  ## Examples

      list_books_with_active_or_first_page()
      #=> [%{book: %Book{}, page: %Page{}}, %{book: %Book{}, page: nil}, ...]

      list_books_with_active_or_first_page(filter: "blue")
      #=> [%{book: %Book{}, page: %Page{}}, ...]

  """

  @spec list_books_with_active_or_first_page(opts :: Keyword.t()) :: [
          %{book: Book.t(), page: Page.t() | nil}
        ]
  def list_books_with_active_or_first_page(opts \\ []) do
    Book
    |> select([b], %{book: b})
    |> maybe_filter_by_partial_name(opts)
    |> with_active_or_first_page()
    |> order_by([b], asc: b.title)
    |> Repo.all()
  end

  @doc """
  Get a book with its active or first page.

  ## Examples

      BookClub.Books.get_book_with_active_or_first_page(1)
      #=> %{book: %Book{}, page: %Page{}}

  """

  @spec get_book_with_active_or_first_page(id()) :: %{book: Book.t(), page: Page.t() | nil}
  def get_book_with_active_or_first_page(id) do
    Book
    |> select([b], %{book: b})
    |> with_active_or_first_page()
    |> Repo.get(id)
  end

  defp maybe_filter_by_partial_name(query, opts) do
    case Keyword.get(opts, :filter) do
      nil -> query
      filter -> from q in query, where: ilike(q.title, ^"%#{filter}%")
    end
  end

  defp with_active_or_first_page(query) do
    pages =
      from p in Page,
        order_by: [
          desc: fragment("? = 'active'", p.status),
          asc: p.number
        ],
        distinct: p.book_id,
        where: not is_nil(p.id)

    from q in query,
      left_join: p in subquery(pages),
      on: q.id == p.book_id,
      select_merge: %{page: p}
  end
end
