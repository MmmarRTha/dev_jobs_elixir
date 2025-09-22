defmodule DevJobsWeb.JobListingsLive.Components do
  use DevJobsWeb, :live_component
  alias DevJobs.JobListings.JobListing

  attr :changeset, Ecto.Changeset, required: true
  attr :job_listing, JobListing, required: true

  def job_form_modal(assigns) do
    assigns =
      assigns
      |> assign(:form, to_form(assigns.changeset))
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
        <h1 class="text-2xl font-black text-primary-50 uppercase">{@modal_config.title}</h1>
        <p class="text-secondary-200 my-6">Fill in the details below to post your job listing</p>
        <.form for={@form} phx-change="validate" phx-submit="save" class="space-y-6">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <.input
              type="text"
              label="Job Title:"
              field={@form[:title]}
              placeholder="e.g., Senior Frontend Developer"
              class="text-base"
            />
            <.input
              type="text"
              label="Company Name:"
              field={@form[:company]}
              placeholder="e.g., Tech Corp"
              class="text-base"
            />
          </div>
          <.input
            type="textarea"
            label="Job Description:"
            field={@form[:description]}
            placeholder="Describe the role, responsibilities, and requirements..."
            rows="4"
            class="text-base"
          />

          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <.input
              type="text"
              label="Location:"
              field={@form[:location]}
              placeholder="e.g., San Francisco, CA"
              class="text-base"
            />
            <.input
              type="number"
              label="Salary (USD):"
              field={@form[:salary]}
              placeholder="e.g., 120000"
              class="text-base"
            />
          </div>
          <div class="flex justify-between items-center gap-8 pt-4">
            <button
              type="button"
              class="px-7 py-4 text-secondary-700 bg-rose-100 hover:bg-rose-200 font-medium rounded-lg transition-colors duration-200"
              phx-click={JS.exec("data-cancel", to: "#job-form-modal")}
            >
              Cancel
            </button>
            <.button class="submit_button px-5 py-4">
              <.icon name="hero-check" class="w-4 h-4 mr-2" />
              {@modal_config.submit}
            </.button>
          </div>
        </.form>
      </div>
    </.modal>
    """
  end

  attr :job_listing, JobListing, required: true
  attr :id, :string, required: true

  def job_listing_rows(assigns) do
    ~H"""
    <div id={@id}>
      <div class="container mb-4 leading-none bg-white rounded-xl">
        <ul>
          <li class="p-8 space-y-1 border border-slate-200 rounded-xl">
            <strong class="flex justify-center pb-2 text-2xl">{@job_listing.title}</strong>
            <div
              :if={
                @job_listing.user && not is_struct(@job_listing.user, Ecto.Association.NotLoaded) &&
                  @job_listing.user.avatar
              }
              class="flex flex-col items-end pb-2"
            >
              <img
                src={~p"/uploads/#{@job_listing.user.avatar}"}
                alt="job-listing-user-avatar"
                class="w-12 h-12 rounded-full"
              />
            </div>
            <p>
              <span class="text-sm text-gray-600 label">Description: </span>{@job_listing.description}
            </p>
            <p>
              <span class="text-sm text-gray-600 label">Location: </span>{@job_listing.location}
            </p>
            <p>
              <span class="text-sm text-gray-600 label">Company: </span>{@job_listing.company}
            </p>
            <p>
              <span class="text-sm text-gray-600 label">Salary: </span>${@job_listing.salary}
            </p>
            <p class="text-xs text-sky-600 label">
              Posted:
              <span class="text-green-500">
                {Timex.from_now(Timex.shift(@job_listing.updated_at, hours: 0))}
              </span>
            </p>
          </li>
        </ul>
      </div>
    </div>
    """
  end

  attr :job_listing, JobListing, required: true
  attr :id, :string, required: true
  attr :current_user, DevJobs.Users.User, default: nil

  def my_job_listing_rows(assigns) do
    ~H"""
    <div id={@id}>
      <div class="container mb-4 leading-none bg-white rounded-xl">
        <ul>
          <li class="p-6 space-y-1 border border-slate-200 rounded-xl">
            <strong class="flex justify-center text-2xl">{@job_listing.title}</strong>
            <p class="pt-2">
              <span class="text-sm text-gray-600 label">Description: </span>{@job_listing.description}
            </p>
            <p>
              <span class="text-sm text-gray-600 label">Location: </span>{@job_listing.location}
            </p>
            <p>
              <span class="text-sm text-gray-600 label">Company: </span>{@job_listing.company}
            </p>
            <p>
              <span class="text-sm text-gray-600 label">Salary: </span>${@job_listing.salary}
            </p>
            <p class="text-xs text-sky-600 label">
              Posted:
              <span class="text-green-500">
                {Timex.from_now(Timex.shift(@job_listing.updated_at, hours: 0))}
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
