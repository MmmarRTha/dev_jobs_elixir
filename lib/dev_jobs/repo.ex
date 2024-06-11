defmodule DevJobs.Repo do
  use Ecto.Repo,
    otp_app: :dev_jobs,
    adapter: Ecto.Adapters.Postgres
end
