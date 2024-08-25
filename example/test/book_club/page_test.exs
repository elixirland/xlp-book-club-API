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

    test "checks if max one active page per book" do
      book = insert!(:book)
      insert!(:page, book_id: book.id, status: :active, number: 1)

      result =
        Page.changeset(%Page{}, %{
          number: 2,
          content: "content",
          status: :active,
          book_id: book.id
        })

      refute result.valid?
      assert {"already has an active page", _} = result.errors[:status]
    end

    test "checks if book's page numbers are sequential" do
      book = insert!(:book)
      insert!(:page, book_id: book.id, number: 1)
      insert!(:page, book_id: book.id, number: 2)

      result =
        Page.changeset(%Page{}, %{
          number: 4,
          content: "content",
          status: :inactive,
          book_id: book.id
        })

      refute result.valid?
      assert {"is not sequential", _} = result.errors[:number]
    end
  end
end
