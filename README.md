# Book Club
This is an Elixirland exercise. Read an introduction to Elixirland at https://github.com/elixirland.

## Status
Exercise: ***Not Reviewed***<br>
Solution: ***Not Reviewed***

> [!NOTE]  
> The possible statuses of exercises and their example solutions are:
> 
>   1. **In Development**: Currently being developed and not ready for use.
>   1. **Not Reviewed**: Available for use but has not been reviewed. Therefore, might contain non-idiomatic Elixir.
>   1. **Reviewed**: Available for use and has been reviewed.
>
> Learn more about the reviewing process [here](https://elixirland.dev/reviewing).

## Introduction
Chris is a member of a book club and wants to develop a simple web API to streamline their group activities. His vision is to create a system that stores books and tracks the pages currently being read and discussed. The book club reads multiple books simultaneously. Although there is already a system in place for tracking who is reading which books, there is no easy way to find the current page being read in any given book.

Chris shares his idea with other members who are also developers. They brainstorm additional features for future stages of the API that they could build together. For now, Chris will create the first version of the API. He and the other developers agreed to include functionality to seed the database with books and pages in this initial version, allowing Chris to easily demonstrate the API on his machine.

## Task description
Develop a Phoenix app that models books and their pages and exposes two endpoints through an API. Ensure your implementation meets the following requirements:
  - Adheres to idiomatic Elixir practices
  - Is well-tested
  - Is easily understandable by others, not just yourself

## Requirements
### Data model
  - Books and pages are stored in a PostgreSQL database
  - Each book has a title
  - Each book can have multiple pages
  - Each page has text content
  - A book can have one active page (or none)

### Seeding
  - Running `mix ecto.setup` creates the database tables but also seeds the database
  - Seeding inserts 4,000 books that each have 400 pages
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
    
#### GET `/api/books/:param`
  - An endpoint for fetching a specific book
  - Retrieves the book along with its active page, or if non exisits, its first page
  - Returns JSON

### Documentation
  - A detailed manual that provides users with all the information they need
  - Includes instructions about how to run and seed the app
  - Includes instructions how to use the endpoints
  - Includes information about the response schemas

> [!TIP]
> You may use a `README.md` (at the root directory) for documentation purposes.

## Assumptions
To keep the exercise simple, you do not have to implement the following:

  - Client authentication and/or authorization
  - Rate limiting
  - Formatting of page text content
  - Non-textual content on pages
  - Pagination

You may assume these issues are already implemented somehow, or are not required.

## How to get started
Fork this repository and implement your solution in the Phoenix app at the root directory. The solution by the Elixirland is located in the directory `/solution`.

Alternatively, you can generate a new Phoenix app by running the `mix phx.new` command. See the [documentation](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.New.html) of this command for more information.

## Example solution
You can find the Elixirland solution to this exercise in its GitHub repository, inside the `/solution` directory.
