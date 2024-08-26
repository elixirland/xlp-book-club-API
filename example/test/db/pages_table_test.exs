defmodule BookClub.PagesTableTest do
  use BookClub.DataCase
  import BookClub.Factory

  test "raises when more than one active page per book" do
    book = insert!(:book)
    insert!(:page, number: 1, book_id: book.id, status: :active)

    assert_raise(Ecto.ConstraintError, fn ->
      insert!(:page, number: 2, book_id: book.id, status: :active)
    end)
  end

  test "raises when page number is zero" do
    book = insert!(:book)

    assert_raise(Ecto.ConstraintError, fn ->
      insert!(:page, number: 0, book_id: book.id)
    end)
  end

  test "raises when page number is negative" do
    book = insert!(:book)

    assert_raise(Ecto.ConstraintError, fn ->
      insert!(:page, number: -1, book_id: book.id)
    end)
  end

  test "raises when page number is not unique for a book" do
    book = insert!(:book)
    insert!(:page, number: 1, book_id: book.id)

    assert_raise(Ecto.ConstraintError, fn ->
      insert!(:page, number: 1, book_id: book.id)
    end)
  end
end
