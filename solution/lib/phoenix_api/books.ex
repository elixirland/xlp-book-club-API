defmodule XlPhoenixAPI.Books do
  import Ecto.Query, warn: false
  alias XlPhoenixAPI.Repo
  alias XlPhoenixAPI.Books.{Book, Page}

  @type id :: non_neg_integer()

  @doc """
  List books with their active or first page.

  See `get_book_with_active_or_first_page/1` for more information.

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
    from(b in Book, select: %{book: b})
    |> maybe_filter_by_partial_name(opts)
    |> with_active_or_last_page()
    |> order_by([b], asc: b.title)
    |> Repo.all()
    |> clear_null_pages()
  end

  @doc """
  Get a book with its active or first page.

  Not all books have an active page. If a book has an active page, it will be returned. If not, the first page of the book will be returned. If a book has no pages, it will still be returned, but with a page with the value `nil`.

  ## Examples

      XlPhoenixAPI.Books.get_book_with_active_or_first_page(1)
      #=> %{book: %Book{}, page: %Page{}}

  """

  @spec get_book_with_active_or_first_page(id()) :: %{book: Book.t(), page: Page.t() | nil}

  def get_book_with_active_or_first_page(id) do
    from(b in Book, select: %{book: b})
    |> with_active_or_last_page()
    |> Repo.get(id)
    |> clear_null_pages()
  end

  defp maybe_filter_by_partial_name(query, opts) do
    case Keyword.get(opts, :filter) do
      nil ->
        query

      filter ->
        from q in query, where: ilike(q.title, ^"%#{filter}%")
    end
  end

  defp with_active_or_last_page(query) do
    pages =
      from p in Page,
        order_by: [
          desc: fragment("? = 'active'", p.status),
          asc: p.number
        ],
        distinct: p.book_id

    from q in query,
      left_join: p in subquery(pages),
      on: q.id == p.book_id,
      select_merge: %{
        page: %Page{
          id: p.id,
          content: p.content,
          number: p.number,
          status: p.status
        }
      }
  end

  defp clear_null_pages(resp) when is_list(resp) do
    Enum.map(resp, fn
      %{page: %{id: nil}} = map -> %{map | page: nil}
      resp -> resp
    end)
  end

  defp clear_null_pages(resp) do
    case resp do
      %{page: %{id: nil}} -> %{resp | page: nil}
      resp -> resp
    end
  end
end
