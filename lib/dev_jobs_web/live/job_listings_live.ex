defmodule DevJobsWeb.JobListingsLive do
  alias DevJobs.JobListings
  use DevJobsWeb, :live_view

  alias DevJobs.JobListings.JobListing

  def mount(_params, _session, socket) do
    job_listing = %JobListing{}
    changeset = JobListing.changeset(job_listing)
    socket = assign(socket, job_listing: job_listing, changeset: changeset)
    {:ok, socket}
  end

  def handle_event("validate", %{"job_listing" => params}, socket) do
    changeset =
      socket.assigns.job_listing
      |> JobListing.changeset(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("create", %{"job_listing" => params}, socket) do
    case JobListings.create_job_listing(params) do
      {:ok, job_listing} ->
        {:noreply,
         socket
         |> put_flash(:info, "Job listing created successfully.")
         |> push_navigate(to: ~p"/jobs")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>Post a Job</h1>
      <.form :let={f} for={@changeset} phx-change="validate" phx-submit="create" class="space-y-6">
        <.input field={f[:title]} placeholder="Title" />
        <.input field={f[:description]} placeholder="Description" />
        <.input field={f[:location]} placeholder="Location" />
        <.input field={f[:company]} placeholder="Company" />
        <.input field={f[:salary]} placeholder="Salary" />
        <.button>Post Job</.button>
      </.form>
    </div>
    """
  end
end
