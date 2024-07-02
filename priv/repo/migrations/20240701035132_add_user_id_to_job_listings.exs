defmodule DevJobs.Repo.Migrations.AddUserIdToJobListings do
  use Ecto.Migration

  def change do
    alter table(:job_listings) do
      add :user_id, references(:users, on_delete: :delete_all)
    end
  end
end
