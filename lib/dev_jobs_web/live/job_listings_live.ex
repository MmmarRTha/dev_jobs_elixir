defmodule DevJobsWeb.JobListingsLive do
  use DevJobsWeb, :live_view
  import DevJobsWeb.JobListingsLive.Components

  alias DevJobs.JobListings
  alias DevJobs.JobListings.JobListing
  alias DevJobs.UserTokens

  def mount(_params, session, socket) do
    current_user =
      case session do
        %{"user_token" => token} -> UserTokens.get_user_by_email_token(token)
        _ -> nil
      end

    socket =
      socket
      |> assign(current_user: current_user)
      |> paginate_job_listings(1)

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
      {:ok, job_listing} ->
        socket = stream_insert(socket, :job_listings, job_listing, at: 0)

        {:noreply,
         socket
         |> put_flash(:info, "Job listing saved successfully.")
         |> push_patch(to: ~p"/")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("delete", %{"id" => id}, socket) do
    case JobListings.delete_job_listing(id) do
      {:ok, job_listing} ->
        socket = stream_delete(socket, :job_listings, job_listing)

        {:noreply,
         socket
         |> put_flash(:info, "Job listing deleted successfully.")
         |> push_patch(to: ~p"/")}

      {:error, message} ->
        socket = put_flash(socket, :error, "Error deleting Job: #{message}")
        {:noreply, socket}
    end
  end

  def handle_event("next-page", _params, socket) do
    new_page = socket.assigns.page + 1
    {:noreply, paginate_job_listings(socket, new_page)}
  end

  def render(assigns) do
    ~H"""
    <div class="flex justify-between">
      <.button
        class="uppercase bg-fuchsia-500 hover:bg-fuchsia-600"
        phx-click={JS.patch(~p"/new") |> show_modal("job-form-modal")}
      >
        Post a new Job
      </.button>
      <.button
        class="hidden uppercase bg-pink-500 hover:bg-pink-600"
        phx-click={show_modal("login-form-modal")}
      >
        login
      </.button>

      <div :if={@current_user}>
        <.link
          href={~p"/users/sessions/logout"}
          method="delete"
          class="px-2 py-3 text-sm font-semibold text-white uppercase bg-blue-500 rounded-lg hover:bg-blue-600"
        >
          Logout
        </.link>
      </div>
    </div>
    <h1 class="my-4 text-xl font-bold text-center uppercase">Job Listings</h1>
    <div id="job_listings" phx-update="stream" phx-viewport-bottom={!@end_of_timeline? && "next-page"}>
      <.job_listing_rows
        :for={{dom_id, job_listing} <- @streams.job_listings}
        id={dom_id}
        job_listing={job_listing}
      />
      <div :if={@end_of_timeline?} class="mt-6 text-sm text-center">
        👩🏻‍💻 There are no more job listings 👩🏼‍💻
      </div>
    </div>
    <.job_form_modal
      :if={@live_action in [:new, :edit]}
      changeset={@changeset}
      job_listing={@job_listing}
    />
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

  defp paginate_job_listings(socket, new_page) do
    job_listings = JobListings.list_job_listings(new_page)

    if Enum.empty?(job_listings) do
      assign(socket, end_of_timeline?: true)
    else
      socket
      |> assign(end_of_timeline?: false)
      |> assign(page: new_page)
      |> stream(:job_listings, job_listings)
    end
  end
end
