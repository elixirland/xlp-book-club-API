defmodule BookClub.BooksTest do
  use BookClub.DataCase
  import BookClub.Factory
  alias BookClub.Books

  describe "list_books_with_active_or_first_page/1" do
    test "lists books with active page" do
      %{id: id} = insert!(:book)
      insert!(:page, book_id: id, number: 1)
      insert!(:page, book_id: id, number: 2, status: :active)
      insert!(:page, book_id: id, number: 3)

      result = Books.list_books_with_active_or_first_page()

      assert length(result) == 1
      assert [%{book: %{id: ^id}}] = result
      assert [%{page: %{status: :active}}] = result
    end

    test "lists books with first page if none are active" do
      %{id: id} = insert!(:book)
      insert!(:page, book_id: id, number: 1)
      insert!(:page, book_id: id, number: 2)
      insert!(:page, book_id: id, number: 3)

      result = Books.list_books_with_active_or_first_page()

      assert length(result) == 1
      assert [%{book: %{id: ^id}}] = result
      assert [%{page: %{number: 1}}] = result
    end

    test "lists books that have no pages" do
      %{id: id} = insert!(:book)

      result = Books.list_books_with_active_or_first_page()

      assert length(result) == 1
      assert [%{book: %{id: ^id}}] = result
      assert [%{page: nil}] = result
    end

    test "alphabetically orders books by title" do
      insert!(:book, title: "Zebra")
      insert!(:book, title: "Apple")
      insert!(:book, title: "Banana")

      result = Books.list_books_with_active_or_first_page()

      assert length(result) == 3

      assert [
               %{book: %{title: "Apple"}},
               %{book: %{title: "Banana"}},
               %{book: %{title: "Zebra"}}
             ] = result
    end

    test "filters books by partial name (case-insensitive)" do
      insert!(:book, title: "Blue")
      insert!(:book, title: "Light blue color")
      insert!(:book, title: "Block")

      result = Books.list_books_with_active_or_first_page(filter: "blu")

      assert length(result) == 2

      assert [
               %{book: %{title: "Blue"}},
               %{book: %{title: "Light blue color"}}
             ] = result
    end
  end

  describe "get_book_with_active_or_first_page/1" do
    test "fetches book with active page" do
      %{id: id} = insert!(:book)
      insert!(:page, book_id: id, number: 1)
      insert!(:page, book_id: id, number: 2, status: :active)
      insert!(:page, book_id: id, number: 3)

      result = Books.get_book_with_active_or_first_page(id)

      assert %{book: %{id: ^id}} = result
      assert %{page: %{status: :active}} = result
    end

    test "fetches book with first page if none are active" do
      %{id: id} = insert!(:book)
      insert!(:page, book_id: id, number: 1)
      insert!(:page, book_id: id, number: 2)
      insert!(:page, book_id: id, number: 3)

      result = Books.get_book_with_active_or_first_page(id)

      assert %{book: %{id: ^id}} = result
      assert %{page: %{number: 1}} = result
    end

    test "fetches books that have no pages" do
      %{id: id} = insert!(:book)

      result = Books.get_book_with_active_or_first_page(id)

      assert %{book: %{id: ^id}} = result
      assert %{page: nil} = result
    end
  end
end
