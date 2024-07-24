# Book Club API
Welcome to the Book Club API! This Phoenix web application provides a public API to access detailed information about the books in our collection and track the reading progress of our members.

Continue reading to find comprehensive instructions on how to run the application and an overview of the available API endpoints.

## Getting started

To set up the application's database with all its tables and populate it with random books and pages, follow these steps:

### Step 1: Set up the database
Run the following command to create an instance of the database, generate all necessary tables, and seed it with random data:

```
mix ecto.setup
```

This command performs the following actions:

  - **Creates the database**: Initializes the required database instance for the application.
  - **Creates tables**: Generates all necessary tables within the database.
  - **Seeds the database**: Populates the database with 4,000 books, each having 10 pages. All book and page data is randomly generated.

### Step 2: Start the server
To start the server, run the following command in your terminal at the root directory of the application:

```
mix phx.server
```

Once the server is running, you can use `http://localhost:4000` as the base URL for your API request calls.

## GET `/api/books` endpoint
An endpoint for fetching all books, along with their active page. If a book does not have an active page, its first page is retrieved. By default, returns all books and orders them alphabetically by book title.

Returns a JSON array of objects with the properties `"book"` and `"page"`. If a book does not have any pages the `"page"` key has the value `null`.

### HTTP response statuses

| Status Code | Description          |
|-------------|----------------------|
| 200         | OK                   |

### Query parameters
- `title`: The title, or partial title, to filter books by. The filter is case-insensitive and matches partial titles. For example, `/api/books?title=blue` returns all books with `"blue"` in their title, regardless of case.

### Response schema
```
{
  "type": "array",
  "items": {
    "type": "object",
    "properties": {
      "book": {
        "type": "object",
        "properties": {
          "id": { "type": "integer" },
          "title": { "type": "string" }
        },
        "required": ["id", "title"]
      },
      "page": {
        "type": ["object", "null"],
        "properties": {
          "id": { "type": "integer" },
          "number": { "type": "integer" },
          "content": { "type": "string" },
          "status": { "type": "string" }
        },
        "required": ["id", "number", "content", "status"]
      }
    },
    "required": ["book"]
  }
}
```

### Example responses
#### `Status: 200`
```
[
  {
    "book": {
      "id": 8,
      "title": "Blue Sky"
    },
    "page": {
      "id": 14,
      "number": 4,
      "content": "She couldn’t shake the feeling that something"...,
      "status": "active"
    }
  },
  {
    "book": {
      "id": 11,
      "title": "The Hungry Kettle"
    },
    "page": {
      "id": 20,
      "number": 0,
      "content": "With one last glance at the darkening forest,"...,
      "status": "inactive"
    }
  },
  {
    "book": {
      "id": 2,
      "title": "Young Cloud On The Roof"
    },
    "page": null
  }
]  
```

## GET `/api/books/:id` endpoint
An endpoint for retrieving a book by its id, along with its active page. If a book does not have an active page, the first page is retrieved.

Returns a JSON object with the properties `"book"` and `"page"`. If a book does not have any pages the `"page"` key has the value `null`.

### HTTP response statuses

| Status Code | Description          |
|-------------|----------------------|
| 200         | OK                   |
| 400         | Bad Request          |
| 404         | Not Found            |

### Path parameters
  - `id`: The id of the book you want to retrieve.

### Response schema
```
{
  "type": "object",
  "properties": {
    "book": {
      "type": "object",
      "properties": {
        "id": { "type": "integer" },
        "title": { "type": "string" }
      },
      "required": ["id", "title"]
    },
    "page": {
      "type": ["object", "null"],
      "properties": {
        "id": { "type": "integer" },
        "number": { "type": "integer" },
        "content": { "type": "string" },
        "status": { "type": "string" }
      },
      "required": ["id", "number", "content", "status"]
    }
  },
  "required": ["book"]
}
```

### Example responses
#### `Status: 200`
```
{
  "book": {
    "id": 8,
    "title": "Blue Sky"
  },
  "page": {
    "id": 14,
    "number": 4,
    "content": "She couldn’t shake the feeling that something"...,
    "status": "active"
  }
}
```

#### `Status: 200`
```
{
  "book": {
    "id": 88,
    "title": "The Large Collider"
  },
  "page": null
}
```

#### `Status: 400`
```
{"error": "Invalid ID"}
```

#### `Status: 404`
```
{"error": "Book not found"}
```
