defmodule XlPhoenixAPIWeb.ApiController do
  use XlPhoenixAPIWeb, :controller
  alias XlPhoenixAPI.Books

  def books(conn, %{"name" => name}) do
    json(
      conn,
      Books.list_books_with_active_or_first_page(filter: name)
    )
  end

  def books(conn, _params) do
    json(
      conn,
      Books.list_books_with_active_or_first_page()
    )
  end

  def book(conn, %{"id" => id}) do
    json(
      conn,
      Books.get_book_with_active_or_first_page(id)
    )
  end
end
