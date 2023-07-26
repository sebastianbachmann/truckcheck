defmodule Truckcheck.Repo do
  use Ecto.Repo,
    otp_app: :truckcheck,
    adapter: Ecto.Adapters.Postgres
end
