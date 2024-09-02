# Book Club API

## Introduction: Help a Book Club Keep Track of Their Reading!

A local book club needs your help! They’re looking for a system to store their books and track reading progress.

Here’s how the book club works:

The club organizes social events where members discuss the pages of a book they read beforehand. At any given time, multiple books are being read simultaneously. Members can choose which events to attend, but they usually select one book and only participate in the events for that book.

Since the club is managing multiple books at once, it’s easy to lose track of which books are being read and where each one left off. Can you save the day by creating an API that helps them keep everything organized and on track?

## Task
Create an API for listing a book club's books, along with the last page that was read.

When implementing the project, you must use:
- Phoenix
- Ecto

## Requirements
### Data model
  - Books and pages are stored in a database
  - Each book has a title
  - Each book can have multiple pages
  - Each page has text content
  - A book can have one active page (or none)

> [!TIP]
> The `mix phx.gen` command in Phoenix creates an application configured to use PostgreSQL by default. For a quick start, consider sticking with PostgreSQL as your database.

### Seeding
To be able to showcase your application, you need to allow for database seeding. Note that the seeding only serves for demonstration (and development) purposes 

  - Running `mix ecto.setup` creates the database tables but also seeds the database
  - Seeding inserts 600 books that each have 400 pages
  - Some seeded books have an active page, but not all
  - Seeding does not take more than a few seconds

> [!NOTE]
> You can use Elixirland's [Xl Faker](https://hex.pm/packages/xl_faker) package to generate random titles and page content.

### Endpoints
#### GET `/api/books`
  - An endpoint that fetching all books in the alphabetical order of their titles
  - Retrieves the books along with their active page or, in case a book doesn't have an active page, their first page
  - Allows for filtering by partial book title
  - Returns JSON
    
#### GET `/api/books/:param`
  - An endpoint for fetching a specific book
  - Retrieves the book along with its active page, or if non exisits, its first page
  - Returns JSON

### Documentation
  - A manual that provides users with all the information they need
  - Includes instructions about how to run and seed the app
  - Includes instructions how to use the endpoints
  - Includes information about the response schemas

> [!TIP]
> Include a README.md file in the root directory of your application to provide documentation.

## Taking it further
To keep the project simple, the requirements are kept relatively simple. However, if you are looking for an extra challenge, consider implementing one or several of the following features:

  - Client authentication and/or authorization
  - Rate limiting
  - Formatting of page text content
  - Non-textual content on pages
  - Pagination

However, keep in mind that the example implementation provided by Elixirland does not cover these features.
