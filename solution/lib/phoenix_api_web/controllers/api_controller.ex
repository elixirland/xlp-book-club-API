defmodule XlPhoenixAPIWeb.ApiController do
  use XlPhoenixAPIWeb, :controller

  def books(conn, _params) do
    books = [
      %{title: "Title A"},
      %{title: "Title B"},
      %{title: "Title C"}
    ]

    json(conn, books)
  end

  def book(conn, %{"id" => id}) do
    json(conn, %{title: "Title #{id}"})
  end
end
