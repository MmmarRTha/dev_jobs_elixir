defmodule DevJobsWeb.JobListingsLive.Components do
  use DevJobsWeb, :live_component
  alias DevJobs.JobListings.JobListing

  attr :changeset, Ecto.Changeset, required: true
  attr :job_listing, JobListing, required: true

  def job_form_modal(assigns) do
    assigns =
      assigns
      |> assign_new(:modal_config, fn ->
        if assigns.job_listing.id do
          %{
            title: "Update Job Listing",
            submit: "Update Job"
          }
        else
          %{
            title: "Post a Job",
            submit: "Post Job"
          }
        end
      end)

    ~H"""
    <.modal id="job-form-modal" show={true} on_cancel={JS.patch(~p"/")}>
      <div>
        <h1 class="text-xl font-bold"><%= @modal_config.title %></h1>
        <.form :let={f} for={@changeset} phx-change="validate" phx-submit="save" class="space-y-6">
          <.input type="text" label="Title:" field={f[:title]} placeholder="Title" />
          <.input type="text" label="Description:" field={f[:description]} placeholder="Description" />
          <.input type="text" label="Location:" field={f[:location]} placeholder="Location" />
          <.input type="text" label="Company:" field={f[:company]} placeholder="Company" />
          <.input type="number" label="Salary:" field={f[:salary]} placeholder="Salary" />
          <.button class="bg-fuchsia-500 hover:bg-fuchsia-600">
            <%= @modal_config.submit %>
          </.button>
        </.form>
      </div>
    </.modal>
    """
  end

  def job_listing_rows(assigns) do
    ~H"""
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
                class="py-1 uppercase bg-sky-500 hover:bg-sky-600"
                phx-click={JS.patch(~p"/edit/#{job_listing.id}") |> show_modal("job-form-modal")}
              >
                Update
              </.button>
              <.button
                class="py-1 uppercase bg-red-500 hover:bg-red-600"
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
end
