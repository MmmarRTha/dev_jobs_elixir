defmodule DevJobsWeb.JobListingsLive do
  alias DevJobs.JobListings
  use DevJobsWeb, :live_view

  alias DevJobs.JobListings.JobListing

  def mount(_params, _session, socket) do
    job_listings = JobListings.list_job_listings()

    socket =
      assign(socket,
        job_listings: job_listings
      )

    {:ok, socket}
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
      {:ok, _job_listing} ->
        {:noreply,
         socket
         |> put_flash(:info, "Job listing posted successfully.")
         |> push_navigate(to: ~p"/")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("delete", %{"id" => id}, socket) do
    case JobListings.delete_job_listing(id) do
      {:ok, _job_listing} ->
        socket = put_flash(socket, :info, "Job listing deleted successfully.")
        {:noreply, push_navigate(socket, to: ~p"/")}

      {:error, message} ->
        socket = put_flash(socket, :error, "Error deleting Job: #{message}")
        {:noreply, socket}
    end
  end

  def render(assigns) do
    ~H"""
    <.button
      class="px-4 py-2 uppercase rounded-full bg-fuchsia-500 hover:bg-fuchsia-600"
      phx-click={JS.patch(~p"/new") |> show_modal("job-form-modal")}
    >
      <%= gettext("Post a new Job") %>
    </.button>

    <.modal id="job-form-modal" show={@live_action in [:new, :edit]} on_cancel={JS.patch(~p"/")}>
      <div>
        <h1>Post a Job</h1>
        <.form :let={f} for={@changeset} phx-change="validate" phx-submit="save" class="space-y-6">
          <.input type="text" label="Title:" field={f[:title]} placeholder="Title" />
          <.input type="text" label="Description:" field={f[:description]} placeholder="Description" />
          <.input type="text" label="Location:" field={f[:location]} placeholder="Location" />
          <.input type="text" label="Company:" field={f[:company]} placeholder="Company" />
          <.input type="number" label="Salary:" field={f[:salary]} placeholder="Salary" />
          <.button class="bg-fuchsia-500 hover:bg-fuchsia-600">Post Job</.button>
        </.form>
      </div>
    </.modal>

    <div>
      <h1 class="text-xl font-bold text-center uppercase">Job Listings</h1>
      <div class="container">
        <ul class="space-y-6">
          <li :for={job_listing <- @job_listings} class="border-b last:border-b-0 ">
            <strong><%= job_listing.title %></strong>
            <p>
              <span class="text-sm text-gray-600 label">Description: </span><%= job_listing.description %>
            </p>
            <p>
              <span class="text-sm text-gray-600 label">Location: </span><%= job_listing.location %>
            </p>
            <p>
              <span class="text-sm text-gray-600 label">Company: </span><%= job_listing.company %>
            </p>
            <p><span class="text-sm text-gray-600 label">Salary: </span>$<%= job_listing.salary %></p>
            <div class="pb-2 text-right">
              <.button
                class="py-1 bg-sky-500 hover:bg-sky-600"
                phx-click={JS.patch(~p"/edit/#{job_listing.id}") |> show_modal("job-form-modal")}
              >
                Update
              </.button>
              <.button
                class="py-1 bg-red-500 hover:bg-red-600"
                phx-click="delete"
                phx-value-id={job_listing.id}
                data-confirm="Are you sure to delete this job?"
              >
                Delete
              </.button>
            </div>
          </li>
        </ul>
      </div>
    </div>
    """
  end

  defp apply_action(:index, _params, socket) do
    assign(socket, changeset: nil)
  end

  defp apply_action(:new, _params, socket) do
    job_listing = %JobListing{}
    changeset = JobListing.changeset(job_listing)
    assign(socket, job_listing: job_listing, changeset: changeset)
  end

  defp apply_action(:edit, %{"id" => id}, socket) do
    job_listing = JobListings.get_job_listing!(id)
    changeset = JobListing.changeset(job_listing)
    assign(socket, job_listing: job_listing, changeset: changeset)
  end
end
