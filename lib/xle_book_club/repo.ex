defmodule XleBookClub.Repo do
  use Ecto.Repo,
    otp_app: :xle_book_club,
    adapter: Ecto.Adapters.Postgres
end
