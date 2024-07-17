# Xl Phoenix API
This is an Elixirland assignment. Read an introduction to Elixirland here: https://github.com/elixirland.

## Status
This repository is **NOT REVIEWED** and **WORK IN PROGRESS**. This status will be set to "reviewed" when enough feedback has been given on the code and documentation in the `solution` directory.

You can provide feedback by [opening an issue](https://github.com/elixirland/xl-phoenix-api/issues/new) or contributing to this repository's [discussions](https://github.com/elixirland/xl-phoenix-api/discussions).

## Assignment
Build a Phoenix app that models books and their pages, and that exposes two endpoints through an API. Make sure that your implementation adheres to idiomatic Elixir and is tested well. Not just code for yourself, but make sure others will understand your code as well.

### Requirements
#### Data model
- Books and pages are stored in a PostgreSQL database
- Each book has a title
- Each book can have multiple pages
- Each page has text-only content
- A book can have one active page (or none)

**Note**: Do not worry to much about what it means for a page to be "active". In case it helps, you might interpret it as the chapter that was last read aloud by a teacher to their class.

#### Seeding
- Running `mix ecto.setup` creates the database tables but also seeds the database
- Seeding inserts 4,000 books that each have 10 pages
- Some seeded books have an active page, but not all
- Seeding is fast

**Note**: You can use the [Xl Faker](https://hex.pm/packages/xl_faker) package to generate random titles and page content.

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
To keep the assignment simple, you do not have to implement the following:

- Client authentication and/or authorization
- Rate limiting
- Formatting of page text content
- Pagination

### How to get started
Fork this repository and implement your solution in the Phoenix app at the root directory. The solution by Elixirland is located in the directory `/solution`.

Alternatively, you can start a new Phoenix app by using the command `mix phx.new`. For more information, see the [mix phx.new](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.New.html) documentation.
