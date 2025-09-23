defmodule DevJobsWeb.JobListingsLive do
  use DevJobsWeb, :live_view
  import DevJobsWeb.JobListingsLive.Components

  alias DevJobs.JobListings

  @impl true
  def mount(%{"search_text" => search_text} = search_params, _session, socket) do
    final_search_params =
      if search_text == "" do
        %{}
      else
        search_params
      end

    {:ok, initialize_search(socket, final_search_params)}
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, initialize_search(socket, %{})}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    socket = apply_action(socket.assigns.live_action, params, socket)
    {:noreply, socket}
  end

  @impl true
  def handle_event("search", %{"search" => %{"search_text" => search_text}}, socket) do
    search_params =
      if search_text == "" do
        %{}
      else
        %{"search_text" => search_text}
      end

    perform_search(socket, search_params)
  end

  @impl true
  def handle_event("search", %{"search" => %{}}, socket) do
    perform_search(socket, %{})
  end

  @impl true
  def handle_event("clear_search", _params, socket) do
    perform_search(socket, %{})
  end

  @impl true
  def handle_event("next-page", _params, socket) do
    if not socket.assigns.searching do
      new_page = socket.assigns.page + 1
      {:noreply, load_more_jobs(socket, new_page)}
    else
      {:noreply, socket}
    end
  end

  @impl true
  def handle_info({:new_jobs_posted, job_listing}, socket) do
    if matches_search?(job_listing, socket.assigns.search_params) do
      new_total = socket.assigns.total_results + 1

      socket =
        socket
        |> assign(total_results: new_total)
        |> stream_insert(:job_listings, job_listing, at: 0)

      {:noreply, socket}
    else
      {:noreply, socket}
    end
  end

  defp initialize_search(socket, search_params) do
    if connected?(socket), do: JobListings.subscribe()

    form = to_form(search_params, as: :search)

    socket
    |> assign(
      form: form,
      search_params: search_params,
      searching: false,
      total_results: 0,
      page: 1,
      end_of_timeline?: false
    )
    |> load_initial_jobs(search_params)
  end

  defp perform_search(socket, search_params) do
    form = to_form(search_params, as: :search)

    job_listings = JobListings.list_job_listings(1, search_params)
    total_results = JobListings.count_job_listings(search_params)

    socket =
      socket
      |> assign(
        form: form,
        search_params: search_params,
        searching: false,
        total_results: total_results,
        page: 1,
        end_of_timeline?: Enum.empty?(job_listings)
      )
      |> stream(:job_listings, job_listings, reset: true)

    {:noreply, socket}
  end

  defp load_initial_jobs(socket, search_params) do
    job_listings = JobListings.list_job_listings(1, search_params)
    total_results = JobListings.count_job_listings(search_params)

    socket
    |> assign(
      searching: false,
      total_results: total_results,
      end_of_timeline?: Enum.empty?(job_listings)
    )
    |> stream(:job_listings, job_listings, reset: true)
  end

  defp load_more_jobs(socket, new_page) do
    job_listings = JobListings.list_job_listings(new_page, socket.assigns.search_params)

    if Enum.empty?(job_listings) do
      socket
      |> assign(end_of_timeline?: true)
    else
      socket
      |> assign(
        end_of_timeline?: false,
        page: new_page
      )
      |> stream(:job_listings, job_listings, reset: false)
    end
  end

  defp matches_search?(job_listing, %{"search_text" => search_text}) when search_text != "" do
    search_text = String.downcase(search_text)
    title = String.downcase(job_listing.title || "")
    description = String.downcase(job_listing.description || "")

    String.contains?(title, search_text) or String.contains?(description, search_text)
  end

  defp matches_search?(_job_listing, %{"search_text" => ""}), do: true
  defp matches_search?(_job_listing, %{}), do: true
  defp matches_search?(_job_listing, _search_params), do: true

  defp apply_action(:index, _params, socket) do
    socket
  end
end
