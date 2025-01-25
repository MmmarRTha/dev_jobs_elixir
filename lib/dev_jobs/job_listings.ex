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
    |> broadcast(:new_jobs_posted)
  end

  def get_job_listing!(id) when is_binary(id), do: get_job_listing!(String.to_integer(id))
  def get_job_listing!(id) when is_integer(id) do
    Repo.get!(JobListing, id)
  end

  def list_job_listings(page \\ 1, params \\ %{}) do
    offset = (page - 1) * @per_page

    JobListing
    |> filter_by_search_params(params)
    |> order_by(desc: :inserted_at)
    |> limit(@per_page)
    |> offset(^offset)
    |> preload(:user)
    |> Repo.all()
  end

  defp filter_by_search_params(query, %{"search_text" => search_text}) do
    search_pattern = "%#{search_text}%"

    where(query, [jobs], ilike(jobs.title, ^search_pattern))
    |> or_where([jobs], ilike(jobs.description, ^search_pattern))

    # |> or_where([jobs], ilike(jobs.location, ^search_pattern))
  end

  defp filter_by_search_params(query, _search_params), do: query

  def list_my_job_listings(page, user_id) do
    offset = (page - 1) * @per_page

    query =
      from(jobs in JobListing,
        where: jobs.user_id == ^user_id,
        limit: @per_page,
        offset: ^offset,
        order_by: [desc: :updated_at]
      )

    Repo.all(query)
  end

  def delete_job_listing(%JobListing{} = job_listing) do
    Repo.delete(job_listing)
  end

  def get_my_job_listings(id, user_id) do
    Repo.get_by!(JobListing, %{id: id, user_id: user_id})
  end

  def subscribe do
    Phoenix.PubSub.subscribe(DevJobs.PubSub, "new_jobs_posted")
  end

  defp broadcast({:error, _reason} = error, _event), do: error

  defp broadcast({:ok, job_listing}, event) do
    Phoenix.PubSub.broadcast(DevJobs.PubSub, "new_jobs_posted", {event, job_listing})
    {:ok, job_listing}
  end
end
