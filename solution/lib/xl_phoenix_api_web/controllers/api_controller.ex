defmodule XlPhoenixAPIWeb.APIController do
  use XlPhoenixAPIWeb, :controller
  alias XlPhoenixAPI.Books

  def books(conn, %{"title" => title}) do
    books = Books.list_books_with_active_or_first_page(filter: title)
    render_pretty_json(conn, books)
  end

  def books(conn, _params) do
    books = Books.list_books_with_active_or_first_page()
    render_pretty_json(conn, books)
  end

  def book(conn, %{"id" => id}) do
    with {:ok, id} <- parse_id(id),
         {:ok, book} <- fetch_book(id) do
      render_pretty_json(conn, book)
    else
      {:error, :invalid_id} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: "Invalid ID"})

      {:error, :not_found} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Book not found"})
    end
  end

  defp render_pretty_json(conn, data) do
    json_string = Jason.encode!(data, pretty: true)
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, json_string)
  end

  defp parse_id(id) do
    case Integer.parse(id) do
      :error -> {:error, :invalid_id}
      {id, _} when id < 1 -> {:error, :invalid_id}
      {id, _} -> {:ok, id}
    end
  end

  defp fetch_book(id) do
    case Books.get_book_with_active_or_first_page(id) do
      nil -> {:error, :not_found}
      book -> {:ok, book}
    end
  end
end
