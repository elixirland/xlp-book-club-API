# Book Club API

## Help a Book Club Keep Track of Their Reading!

A local book club needs your help! They’re looking for a system to store their collection of books and monitor each book’s reading progress.

The book club organizes reoccuring meeting for book that is currently being read, during which members discuss the pages they've read at home. There are multiple books that are being read in parallel, and members can freely join any of the discussions.

Because the club is juggling multiple books being read at the same time, it easy to lose track of what books are being read and the last read pages of those books. Can you save the day by creating an API that helps them keep everything organized and on track?

## Task description
Create an application using Phoenix that exposes an API to manage a collection of books and their pages.

Your implementation should meet the following criteria:

  - Follows idiomatic Elixir practices
  -	Is thoroughly tested
  -	Is easily understandable and maintainable by other developers

Refer to the ‘Requirements’ section for a detailed list of specifications for your application.

## Preview
Watch this short clip to see the final result in action.

[preview.webm](https://github.com/user-attachments/assets/135893ed-42ab-420b-925f-4c736ae1db78)

## Requirements
### Data model
  - Books and pages are stored in a database
  - Utilizes the Ecto library for data management and querying
  - Each book has a title
  - Each book can have multiple pages
  - Each page has text content
  - A book can have one active page (or none)

> [!TIP]
> The `mix phx.gen` command in Phoenix creates an application configured to use PostgreSQL by default. For a quick start, consider sticking with PostgreSQL as your database.

### Seeding
  - Running `mix ecto.setup` creates the database tables but also seeds the database
  - Seeding inserts 600 books that each have 400 pages
  - Some seeded books have an active page, but not all
  - Seeding does not take more than a few seconds

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
> Include a README.md file in the root directory of your application to provide documentation.

## Limitations
To keep the project simple, you do not have to implement the following:

  - Client authentication and/or authorization
  - Rate limiting
  - Formatting of page text content
  - Non-textual content on pages
  - Pagination

You may assume these issues are already implemented somehow, or are not required.

For an added challenge, try implementing one or more of these features. However, keep in mind that the example implementation provided by Elixirland does not cover these features.
