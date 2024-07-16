defmodule XlPhoenixAPI.Books do
  import Ecto.Query, warn: false
  alias XlPhoenixAPI.Repo
  alias XlPhoenixAPI.Books.{Book, Page}

  def list_books_with_active_or_first_page do
    from(b in Book, select: %{book: b})
    |> with_active_or_last_page()
    |> order_by([b], asc: b.title)
    |> Repo.all()
  end

  def get_book_with_active_or_first_page(id) do
    from(
      b in Book,
      where: b.id == ^id,
      select: %{book: b}
    )
    |> with_active_or_last_page()
    |> Repo.one()
  end

  defp with_active_or_last_page(query) do
    pages_query =
      from p in Page,
        order_by: [
          desc: fragment("? = 'active'", p.status),
          asc: p.number
        ],
        distinct: p.book_id

    from q in query,
      left_join: p in subquery(pages_query),
      on: q.id == p.book_id,
      select_merge: %{
        page: %{
          id: p.id,
          content: p.content,
          number: p.number,
          status: p.status
        }
      }
  end
end
