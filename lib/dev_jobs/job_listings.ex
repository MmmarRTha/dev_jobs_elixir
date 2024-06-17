defmodule DevJobs.JobListings do
  @moduledoc """
  The JobListings context.
  """

  import Ecto.Query, warn: false
  alias DevJobs.Repo
  alias DevJobs.JobListings.JobListing

  def create_job_listing(attrs \\ %{}) do
    %JobListing{}
    |> JobListing.changeset(attrs)
    |> Repo.insert()
  end

  def update_job_listing(%JobListing{} = job_listing, attrs) do
    job_listing
    |> JobListing.changeset(attrs)
    |> Repo.update()
  end

  def get_job_listing!(id) do
    Repo.get!(JobListing, id)
  end

  def list_job_listings do
    query = from(jobs in JobListing, order_by: [desc: :inserted_at])
    Repo.all(query)
  end
end
