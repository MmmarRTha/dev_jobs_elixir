defmodule DevJobs.JobListings do
  @moduledoc """
  The JobListings context.
  """

  import Ecto.Query, warn: false
  alias DevJobs.Repo
  alias DevJobs.JobListings.JobListing

  def save_job_listing(%JobListing{} = job_listing, attrs) do
    job_listing
    |> JobListing.changeset(attrs)
    |> Repo.insert_or_update()
  end

  def get_job_listing!(id), do: Repo.get!(JobListing, id)

  def list_job_listings do
    query = from(jobs in JobListing, order_by: [desc: :inserted_at])
    Repo.all(query)
  end

  def delete_job_listing(id) do
    job_listing = Repo.get!(JobListing, id)
    Repo.delete(job_listing)
  end
end
