defmodule BookClub.Repo do
  use Ecto.Repo,
    otp_app: :book_club,
    adapter: Ecto.Adapters.Postgres
end
