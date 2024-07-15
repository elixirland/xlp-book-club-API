defmodule XlPhoenixAPI.Books.Page do
  use Ecto.Schema
  import Ecto.Changeset
  alias XlPhoenixAPI.Books.Book

  @type status :: :active | :inactive

  @type t :: %__MODULE__{
          id: non_neg_integer(),
          number: non_neg_integer(),
          content: String.t(),
          status: status(),
          book_id: non_neg_integer()
        }

  @statuses [:active, :inactive]

  schema "pages" do
    field :number, :integer
    field :content, :string
    field :status, Ecto.Enum, values: @statuses, default: :inactive

    belongs_to :book, Book

    timestamps()
  end

  def changeset(page, attrs) do
    page
    |> cast(attrs, [:number, :content, :status, :book_id])
    |> validate_required([:number, :content, :status])
    |> validate_inclusion(:status, @statuses)
  end
end
