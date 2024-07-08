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
    <.modal id="job-form-modal" show={true} on_cancel={JS.patch(~p"/my-job-listings")}>
      <div>
        <h1 class="text-xl font-bold"><%= @modal_config.title %></h1>
        <.form :let={f} for={@changeset} phx-change="validate" phx-submit="save" class="space-y-6">
          <.input type="text" label="Title:" field={f[:title]} placeholder="Title" />
          <.input type="text" label="Description:" field={f[:description]} placeholder="Description" />
          <.input type="text" label="Location:" field={f[:location]} placeholder="Location" />
          <.input type="text" label="Company:" field={f[:company]} placeholder="Company" />
          <.input type="number" label="Salary:" field={f[:salary]} placeholder="Salary" />
          <.button class="text-gray-900 bg-teal-400 hover:bg-teal-500 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2">
            <%= @modal_config.submit %>
          </.button>
        </.form>
      </div>
    </.modal>
    """
  end

  attr :job_listing, JobListing, required: true
  attr :id, :string, required: true
  attr :current_user, DevJobs.Users.User, default: nil

  def job_listing_rows(assigns) do
    ~H"""
    <div id={@id}>
      <div class="container mb-4 leading-none bg-white rounded-xl">
        <ul>
          <li class="p-6 space-y-1 border border-slate-200 rounded-xl">
            <strong class="flex justify-center text-2xl"><%= @job_listing.title %></strong>
            <div :if={@job_listing.user_id && @job_listing.user.avatar} class="flex flex-col items-end">
                <img src={~p"/uploads/#{@job_listing.user.avatar}"} alt="job-listing-user-avatar" class="w-8 h-8 rounded-full">
               <p class="pt-1 text-xs text-slate-500"><%= @job_listing.user.email %></p>
            </div>
            <p class="pt-2">
              <span class="text-sm text-gray-600 label">Description: </span><%= @job_listing.description %>
            </p>
            <p>
              <span class="text-sm text-gray-600 label">Location: </span><%= @job_listing.location %>
            </p>
            <p>
              <span class="text-sm text-gray-600 label">Company: </span><%= @job_listing.company %>
            </p>
            <p>
              <span class="text-sm text-gray-600 label">Salary: </span>$<%= @job_listing.salary %>
            </p>
            <p class="text-xs text-sky-600 label">
              Posted:
              <span class="text-green-500">
                <%= Timex.from_now(Timex.shift(@job_listing.updated_at, hours: 0)) %>
              </span>
            </p>
            <div
              :if={@current_user && @current_user.id == @job_listing.user_id}
              class="flex justify-end space-x-4"
            >
              <.button
                class="text-xs text-white uppercase bg-blue-500 hover:bg-blue-700 py-1.5 px-2 rounded-lg"
                phx-click={
                  JS.patch(~p"/my-job-listings/edit/#{@job_listing.id}")
                  |> show_modal("job-form-modal")
                }
              >
                Update
              </.button>
              <.button
                class="text-xs text-white uppercase bg-red-500 hover:bg-red-700 py-1.5 px-2 rounded-lg"
                phx-click="delete"
                phx-value-id={@job_listing.id}
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
