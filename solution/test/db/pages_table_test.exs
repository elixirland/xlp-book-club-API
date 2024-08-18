defmodule BookClub.PagesTableTest do
  use BookClub.DataCase
  import BookClub.Factory

  test "raises when more than one active page per book" do
    book = insert!(:book)
    insert!(:page, number: 1, book_id: book.id, status: :active)

    assert_raise(
      Ecto.ConstraintError,
      fn ->
        insert!(:page, number: 2, book_id: book.id, status: :active)
      end
    )
  end

  test "raises when numbers of pages are not sequential" do
    book = insert!(:book)
    insert!(:page, number: 1, book_id: book.id)
    insert!(:page, number: 2, book_id: book.id)

    assert_raise(
      Postgrex.Error,
      fn ->
        insert!(:page, number: 4, book_id: book.id)
      end
    )
  end
end
