defmodule DevJobsWeb.JobListingsLive do
  use DevJobsWeb, :live_view
  import DevJobsWeb.JobListingsLive.Components

  alias DevJobs.JobListings

  def mount(_params, _session, socket) do
    {:ok, paginate_job_listings(socket, 1)}
  end

  def handle_params(params, _uri, socket) do
    socket = apply_action(socket.assigns.live_action, params, socket)
    {:noreply, socket}
  end

  def handle_event("next-page", _params, socket) do
    new_page = socket.assigns.page + 1
    {:noreply, paginate_job_listings(socket, new_page)}
  end

  def render(assigns) do
    ~H"""
    <h1 class="my-4 text-xl font-bold text-center text-white uppercase">Job Listings</h1>

    <div id="job_listings" phx-update="stream" phx-viewport-bottom={!@end_of_timeline? && "next-page"}>
      <.job_listing_rows
        :for={{dom_id, job_listing} <- @streams.job_listings}
        id={dom_id}
        job_listing={job_listing}
        current_user={@current_user}
      />
      <div :if={@end_of_timeline?} class="mt-6 text-sm text-center">
        👩🏻‍💻 There are no more job listings 👩🏼‍💻
      </div>
    </div>
    """
  end

  defp apply_action(:index, _params, socket) do
    socket
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
