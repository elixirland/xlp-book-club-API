defmodule XlPhoenixAPI.Books do
  import Ecto.Query, warn: false
  alias XlPhoenixAPI.Repo
  alias XlPhoenixAPI.Books.Book

  @spec create_book(String.t(), list(String.t())) ::
          {:ok, Book.t()} | {:error, Ecto.Changeset.t()}

  def create_book(title, page_texts) do
    %Book{}
    |> Book.changeset(%{
      title: title,
      pages: build_pages(page_texts)
    })
    |> Repo.insert()
  end

  defp build_pages(page_texts) do
    page_texts
    |> Enum.with_index(1)
    |> Enum.map(fn {content, number} -> %{content: content, number: number} end)
  end
end
