defmodule BookClub.PageTest do
  use BookClub.DataCase
  import BookClub.Factory
  alias BookClub.Books.Page

  describe "changeset/2" do
    test "valid changeset" do
      attrs = %{
        number: 1,
        content: "content",
        status: :active,
        book_id: 1
      }

      changeset = Page.changeset(%Page{}, attrs)

      assert changeset.valid?
    end
  end
end
