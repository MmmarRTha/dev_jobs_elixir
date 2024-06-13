defmodule DevJobs.Repo.Migrations.CreateJobListings do
  use Ecto.Migration

  def change do
    create table(:job_listings) do
      add :title, :string
      add :description, :string
      add :location, :string
      add :company, :string
      add :salary, :decimal

      timestamps()
    end
  end
end
