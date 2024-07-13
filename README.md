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
- Each page has some text-only content
- A book can have one active page (or none)
- Book titles are not guarenteed to be unique

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

## How to run the app

## Endpoints
