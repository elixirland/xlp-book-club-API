# Book Club
This is an Elixirland exercise. Read an introduction to Elixirland here: https://github.com/elixirland.

## Status
Description: *In Development*<br>
Solution:    *In Development*

> [!NOTE]  
> The possible statuses of exercise descriptions and example solutions are:
> 
>   1. **In Development**: Currently being developed and not ready for use.
>   1. **Not Reviewed**: Available for use but has not been reviewed.
>   1. **Reviewed**: Available for use and has been reviewed.

> [!IMPORTANT]  
> Exercises that are reviewed might still undergo changes, to ensure continuous improvement. You can provide feedback by [opening an issue](https://github.com/elixirland/xlc-book-club/issues/new) or contributing to this repository's [discussions](https://github.com/elixirland/xlc-book-club/discussions).

## Background
Chris is a member of a book club and wants to develop a simple web API to streamline their group activities. His vision is to create a system that stores books and tracks the pages currently being read and discussed. The book club reads multiple books simultaneously. Although there is already a system in place for tracking who is reading which books, there is no easy way to find the current page being read in any given book.

## Task
Develop a Phoenix app that models books and their pages and exposes two endpoints through an API. Ensure your implementation meets the following requirements:
  - Adheres to idiomatic Elixir practices
  - Is well-tested
  - Is easily understandable by others, not just yourself

## Requirements
### Data model
  - Books and pages are stored in a PostgreSQL database
  - Each book has a title
  - Each book can have multiple pages
  - Each page has text-only content
  - A book can have one active page (or none)

### Seeding
  - Running `mix ecto.setup` creates the database tables but also seeds the database
  - Seeding inserts 4,000 books that each have 10 pages
  - Some seeded books have an active page, but not all
  - Seeding is fast

> [!TIP]
> You can use Elixirland's [Xl Faker](https://hex.pm/packages/xl_faker) package to generate random titles and page content.

### Endpoints
#### GET `/api/books`
  - An endpoint that fetching all books in the alphabetical order of their titles
  - Retrieves the books along with their active pages, or if non exisits, their first pages
  - Allows for filtering by partial book title
  - Returns JSON
    
#### GET `/api/books/:id`
  - An endpoint for fetching a specific book
  - Retrieves the book along with its active page, or if non exisits, its first page
  - Returns JSON

### README
  - A detailed manual that provides users with all the information they need
  - Includes information about what is stored in the database
  - Includes instructions about how to run and seed the app
  - Includes instructions how to use the endpoints

## Assumptions
To keep the exercise simple, you do not have to implement the following:

  - Client authentication and/or authorization
  - Rate limiting
  - Formatting of page text content
  - Pagination

You may assume these issues are already handled somehow.

## How to get started
Fork this repository and implement your solution in the Phoenix app at the root directory. The solution by Elixirland is located in the directory `/solution`.

Alternatively, you can start a new app from your command line. Generate a new Phoenix app by using the command `mix phx.new` (see the [docs](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.New.html) for more information) or `mix new` to generate a new Mix project (see the [documentation](https://hexdocs.pm/mix/1.12/Mix.Tasks.New.html) for more information).

## Example solution
You can find the Elixirland solution to this exercise in its GitHub repository, inside the `/solution` directory.
