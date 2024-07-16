defmodule XlPhoenixAPIWeb.ApiController do
  use XlPhoenixAPIWeb, :controller
  alias XlPhoenixAPI.Books

  def books(conn, _params) do
    books = Books.list_books_with_active_or_first_page()

    json(conn, books)
  end

  def book(conn, %{"id" => id}) do
    book = Books.get_book(id)

    json(conn, book)
  end
end
