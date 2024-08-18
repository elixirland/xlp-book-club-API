defmodule BookClub.BookTest do
  use BookClub.DataCase
  alias BookClub.Books.Book

  describe "changeset/2" do
    test "valid changeset" do
      attrs = %{
        title: "some title"
      }

      changeset = Book.changeset(%Book{}, attrs)

      assert changeset.valid?
    end
  end
end
