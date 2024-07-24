defmodule BookClub.Factory do
  alias BookClub.Repo
  alias BookClub.Books.{Book, Page}

  def insert!(name, attrs \\ []) do
    name
    |> build(attrs)
    |> Repo.insert!()
  end

  defp build(name, attrs) do
    name
    |> build_default()
    |> struct!(attrs)
  end

  defp build_default(:book) do
    %Book{title: "A Great Journey"}
  end

  defp build_default(:page) do
    %Page{
      content: "Once upon a time...",
      status: :inactive
    }
  end
end
