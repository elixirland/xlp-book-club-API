defmodule XlPhoenixAPI.Repo do
  use Ecto.Repo,
    otp_app: :xl_phoenix_api,
    adapter: Ecto.Adapters.Postgres
end
