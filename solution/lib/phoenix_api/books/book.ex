defmodule XlPhoenixAPI.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset
  alias XlPhoenixAPI.Books.Page

  @type t :: %__MODULE__{
          id: non_neg_integer(),
          title: String.t(),
          pages: [Page.t()]
        }

  @derive {Jason.Encoder, only: [:id, :title]}

  schema "books" do
    field :title, :string

    has_many :pages, Page

    timestamps()
  end

  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title])
    |> cast_assoc(:pages)
    |> validate_required([:title])
  end
end
