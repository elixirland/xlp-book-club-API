defmodule XlPhoenixAPIWeb.ApiController do
  use XlPhoenixAPIWeb, :controller
  alias XlPhoenixAPI.Books

  def books(conn, %{"name" => name}) do
    books = Books.list_books_with_active_or_first_page(filter: name)
    json(conn, books)
  end

  def books(conn, _params) do
    books = Books.list_books_with_active_or_first_page()
    json(conn, books)
  end

  def book(conn, %{"id" => id}) do
    case Books.get_book_with_active_or_first_page(id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Book not found"})

      book ->
        json(conn, book)
    end
  end
end
