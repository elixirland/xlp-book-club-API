# Phoenix API

## Status
This repository is **NOT REVIEWED** and **WORK IN PROGRESS**.

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

**Note**: You can use the *Elixirland random generator* package to generate random titles and page content.

TODO: Add link to Elixirland random generator on https://hexdocs.pm.

#### API
- An endpoint that fetching all books and allows for filtering by partial book title
- An endpoint for fetching a book with its active chapter, or if non exisits, the first chapter
- Both endpoints return JSON

#### README
- Instructions how to run the app
- Instructions how to use the endpoints

### Don't worry about
To keep the assignment simple, you do not have to implement the following:

- Client authentication and/or authorization
- Rate limiting
- Formatting of page text content

___ 

## How to run and seed the app
*Insert your text here*

## Endpoints
*Insert your text here*
