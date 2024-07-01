defmodule DevJobs.JobListings do
  @moduledoc """
  The JobListings context.
  """

  import Ecto.Query, warn: false
  alias DevJobs.Repo
  alias DevJobs.JobListings.JobListing

  @per_page 10

  def save_job_listing(%JobListing{} = job_listing, attrs) do
    job_listing
    |> JobListing.changeset(attrs)
    |> Repo.insert_or_update()
  end

  def get_job_listing!(id), do: Repo.get!(JobListing, id)

  def list_job_listings(page \\ 1) do
    offset = (page - 1) * @per_page

    query =
      from(jobs in JobListing, limit: @per_page, offset: ^offset, order_by: [desc: :inserted_at])

    Repo.all(query)
  end

  def delete_job_listing(id) do
    job_listing = Repo.get!(JobListing, id)
    Repo.delete(job_listing)
  end

  def get_my_job_listings(id, user_id) do
    Repo.get_by!(JobListing, %{id: id, user_id: user_id})
  end
end
