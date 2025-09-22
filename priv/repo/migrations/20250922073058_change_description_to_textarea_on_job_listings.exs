defmodule DevJobs.Repo.Migrations.ChangeDescriptionToTextareaOnJobListings do
  use Ecto.Migration

  def change do
    alter table(:job_listings) do
      modify :description, :text
    end
  end
end
