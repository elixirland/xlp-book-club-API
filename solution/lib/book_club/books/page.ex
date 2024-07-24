defmodule BookClub.Books.Page do
  use Ecto.Schema
  import Ecto.Changeset
  alias BookClub.Books.Book

  @type status :: :active | :inactive

  @type t :: %__MODULE__{
          id: non_neg_integer(),
          number: non_neg_integer(),
          content: String.t(),
          status: status(),
          book_id: non_neg_integer()
        }

  @derive {Jason.Encoder, only: [:id, :number, :content, :status]}

  @statuses [:active, :inactive]

  schema "pages" do
    field :number, :integer
    field :content, :string
    field :status, Ecto.Enum, values: @statuses, default: :inactive
    belongs_to :book, Book

    timestamps()
  end

  @doc false
  def changeset(page, attrs) do
    page
    |> cast(attrs, [:number, :content, :status, :book_id])
    |> validate_required([:number, :content, :status])
    |> validate_inclusion(:status, @statuses)
    |> validate_number(:number, greater_than: 0)
  end
end
