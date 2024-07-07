defmodule DevJobsWeb.JobListingsLive do
  use DevJobsWeb, :live_view
  import DevJobsWeb.JobListingsLive.Components

  alias DevJobs.JobListings

  def mount(%{"search_text" => _search_text} = search_params, _session, socket) do
    {:ok, filter_job_listings(socket, search_params)}
  end

  def mount(_params, _session, socket) do
    {:ok, filter_job_listings(socket)}
  end

  defp filter_job_listings(socket, search_params \\ %{}) do
    if connected?(socket), do: JobListings.subscribe()
    form = to_form(search_params)
    socket = assign(socket, form: form, search_params: search_params)
    paginate_job_listings(socket, 1, search_params)
  end

  def handle_params(params, _uri, socket) do
    socket = apply_action(socket.assigns.live_action, params, socket)
    {:noreply, socket}
  end

  def handle_event("next-page", _params, socket) do
    new_page = socket.assigns.page + 1
    {:noreply, paginate_job_listings(socket, new_page, socket.assigns.search_params)}
  end

  def handle_info({:new_jobs_posted, job_listing}, socket) do
    {:noreply, stream_insert(socket, :job_listings, job_listing, at: 0)}
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
