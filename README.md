# Book Club
This is an Elixirland exercise. Read an introduction to Elixirland here: https://github.com/elixirland.

## Status
This repository is **NOT REVIEWED** and **WORK IN PROGRESS**. This status will be set to "reviewed" when enough feedback has been given on the code and documentation in the `/solution` directory.

You can provide feedback by [opening an issue](https://github.com/elixirland/xlc-book-club/issues/new) or contributing to this repository's [discussions](https://github.com/elixirland/xlc-book-club/discussions).

## Description
### Background
Chris is a member of a book club and wants to develop a simple web API to streamline their group activities. His vision is to create a system that stores books and tracks the pages currently being read and discussed. The book club reads multiple books simultaneously. Although there is already a system in place for tracking who is reading which books, there is no easy way to find the current page being read in any given book.

### Task
Develop a Phoenix app that models books and their pages and exposes two endpoints through an API. Ensure your implementation meets the following requirements:
  - Adheres to idiomatic Elixir practices
  - Is well-tested
  - Is easily understandable by others, not just yourself

### Requirements
#### Data model
  - Books and pages are stored in a PostgreSQL database
  - Each book has a title
  - Each book can have multiple pages
  - Each page has text-only content
  - A book can have one active page (or none)

#### Seeding
  - Running `mix ecto.setup` creates the database tables but also seeds the database
  - Seeding inserts 4,000 books that each have 10 pages
  - Some seeded books have an active page, but not all
  - Seeding is fast

> [!TIP]
> You can use Elixirland's [Xl Faker](https://hex.pm/packages/xl_faker) package to generate random titles and page content.

#### Endpoints
##### GET `/api/books`
  - An endpoint that fetching all books in the alphabetical order of their titles
  - Retrieves the books along with their active pages, or if non exisits, their first pages
  - Allows for filtering by partial book title
  - Returns JSON
    
##### GET `/api/books/:id`
  - An endpoint for fetching a specific book
  - Retrieves the book along with its active page, or if non exisits, its first page
  - Returns JSON

#### README
  - A detailed manual that provides users with all the information they need
  - Includes information about what is stored in the database
  - Includes instructions about how to run and seed the app
  - Includes instructions how to use the endpoints

### Don't worry about
To keep the exercise simple, you do not have to implement the following:

  - Client authentication and/or authorization
  - Rate limiting
  - Formatting of page text content
  - Pagination

## How to get started
Fork this repository and implement your solution in the Phoenix app at the root directory. The solution by Elixirland is located in the directory `/solution`.

Alternatively, you can start a new Phoenix app by using the command `mix phx.new`. For more information, see the [mix phx.new](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.New.html) documentation.
