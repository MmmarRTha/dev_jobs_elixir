defmodule DevJobsWeb.MyJobListingsLive do
  use DevJobsWeb, :live_view
  import DevJobsWeb.JobListingsLive.Components

  alias DevJobs.JobListings
  alias DevJobs.JobListings.JobListing

  def mount(_params, _session, socket) do
    {:ok, paginate_job_listings(socket, 1)}
  end

  def handle_params(params, _uri, socket) do
    socket = apply_action(socket.assigns.live_action, params, socket)
    {:noreply, socket}
  end

  def handle_event("validate", %{"job_listing" => params}, socket) do
    changeset =
      socket.assigns.job_listing
      |> JobListing.changeset(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"job_listing" => params}, socket) do
    case JobListings.save_job_listing(socket.assigns.job_listing, params) do
      {:ok, job_listing} ->
        socket = stream_insert(socket, :job_listings, job_listing, at: 0)

        {:noreply,
         socket
         |> put_flash(:info, "Job listing saved successfully.")
         |> push_patch(to: ~p"/my-job-listings")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("delete", %{"id" => id}, socket) do
    case JobListings.get_my_job_listings(id, socket.assigns.current_user.id) do
      {:ok, job_listing} ->
        socket = stream_delete(socket, :job_listings, job_listing)

        {:noreply,
         socket
         |> put_flash(:info, "Job listing deleted successfully.")
         |> push_patch(to: ~p"/my-job-listings")}

      {:error, message} ->
        socket = put_flash(socket, :error, "Error deleting Job: #{message}")
        {:noreply, socket}
    end
  end

  def handle_event("next-page", _params, socket) do
    new_page = socket.assigns.page + 1
    {:noreply, paginate_job_listings(socket, new_page)}
  end

  defp apply_action(:index, _params, socket) do
    socket
  end

  defp apply_action(:new, _params, socket) do
    job_listing = %JobListing{user_id: socket.assigns.current_user.id}
    changeset = JobListing.changeset(job_listing)
    assign(socket, job_listing: job_listing, changeset: changeset)
  end

  defp apply_action(:edit, %{"id" => id}, socket) do
    job_listing = JobListings.get_my_job_listings(id, socket.assigns.current_user.id)
    changeset = JobListing.changeset(job_listing)
    assign(socket, job_listing: job_listing, changeset: changeset)
  end

  defp apply_action(:my_job_listings, _params, socket) do
    socket
  end

  defp paginate_job_listings(socket, new_page) do
    job_listings = JobListings.list_my_job_listings(new_page, socket.assigns.current_user.id)

    if Enum.empty?(job_listings) do
      socket
      |> assign(end_of_timeline?: true)
      |> stream(:job_listings, [])
    else
      socket
      |> assign(end_of_timeline?: false)
      |> assign(page: new_page)
      |> stream(:job_listings, job_listings)
    end
  end
end
