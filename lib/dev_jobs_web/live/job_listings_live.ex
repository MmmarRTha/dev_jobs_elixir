defmodule DevJobsWeb.JobListingsLive do
  use DevJobsWeb, :live_view
  import DevJobsWeb.JobListingsLive.Components

  alias DevJobs.JobListings

  def mount(_params, _session, socket) do
    if connected?(socket), do: JobListings.subscribe()
    search_params = %{}
    search_form = to_form(search_params)
    socket = assign(socket, search_form: search_form, search_params: search_params)
    {:ok, paginate_job_listings(socket, 1, search_params)}
  end

  def handle_params(params, _uri, socket) do
    socket = apply_action(socket.assigns.live_action, params, socket)
    {:noreply, socket}
  end

  def handle_event("next-page", _params, socket) do
    new_page = socket.assigns.page + 1
    {:noreply, paginate_job_listings(socket, new_page, socket.assigns.search_params)}
  end

  def handle_event("search-job", search_params, socket) do
    new_page = socket.assigns.page

    socket =
      socket
      |> paginate_job_listings(new_page, search_params)
      |> stream(:job_listings, [], reset: true)

    {:noreply, socket}
  end

  def handle_info({:new_jobs_posted, job_listing}, socket) do
    {:noreply, stream_insert(socket, :job_listings, job_listing, at: 0)}
  end

  def render(assigns) do
    ~H"""
    <.simple_form for={@search_form} autocomplete="off" phx-submit="search-job">
      <.input field={@search_form[:search_text]} placeholder="Search Job..." />
      <:actions>
        <.button class="px-4 py-2 font-bold text-white rounded-md bg-cyan-500 hover:bg-cyan-700">
          Search
        </.button>
      </:actions>
    </.simple_form>
    <h1 class="my-4 text-xl font-bold text-center text-white uppercase">Job Listings</h1>

    <div id="job_listings" phx-update="stream" phx-viewport-bottom={!@end_of_timeline? && "next-page"}>
      <.job_listing_rows
        :for={{dom_id, job_listing} <- @streams.job_listings}
        id={dom_id}
        job_listing={job_listing}
      />
      <div :if={@end_of_timeline?} class="mt-6 text-sm text-center text-white">
        👩🏻‍💻 There are no job listings 👩🏼‍💻
      </div>
    </div>
    """
  end

  defp apply_action(:index, _params, socket) do
    socket
  end

  defp paginate_job_listings(socket, new_page, search_params) do
    job_listings = JobListings.list_job_listings(new_page, search_params)

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
