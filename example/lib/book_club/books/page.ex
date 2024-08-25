defmodule BookClub.Books.Page do
  use Ecto.Schema
  import Ecto.Query, warn: false
  import Ecto.Changeset
  alias BookClub.Repo
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
  @spec changeset(t, map) :: Ecto.Changeset.t()
  def changeset(page, attrs) do
    page
    |> cast(attrs, [:number, :content, :status, :book_id])
    |> validate_required([:number, :content, :status])
    |> validate_inclusion(:status, @statuses)
    |> validate_max_one_active_page()
    |> validate_page_sequence()
  end

  @spec validate_max_one_active_page(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  defp validate_max_one_active_page(changeset) do
    book_id = get_field(changeset, :book_id)
    status = get_field(changeset, :status)

    if status == :active do
      active_pages =
        __MODULE__
        |> where([p], p.book_id == ^book_id)
        |> where([p], p.status == ^status)
        |> Repo.all()

      case active_pages do
        [] -> changeset
        _ -> add_error(changeset, :status, "already has an active page")
      end
    else
      changeset
    end
  end

  @spec validate_page_sequence(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  defp validate_page_sequence(changeset) do
    book_id = get_field(changeset, :book_id)
    number = get_field(changeset, :number)

    book_pages =
      __MODULE__
      |> where([p], p.book_id == ^book_id)
      |> order_by(asc: :number)
      |> Repo.all()

    case book_pages do
      [] ->
        changeset

      pages ->
        last_page_number = List.last(pages).number

        if last_page_number + 1 == number do
          changeset
        else
          add_error(changeset, :number, "is not sequential")
        end
    end
  end
end
