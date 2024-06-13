defmodule DevJobsWeb.JobListingsLive do
    use DevJobsWeb, :live_view

    alias DevJobs.JobListings.JobListing


    def mount(_params, _session, socket) do
        job_listing = %JobListing{}
        changeset = JobListing.changeset(job_listing)
        socket = assign(socket, job_listing: job_listing, changeset: changeset)
        {:ok, socket}
    end

    def handle_event("validate", %{"job_listing" => params}, socket) do
        IO.inspect("__________")
        IO.inspect(params)
        IO.inspect("__________")
        changeset =
            socket.assigns.job_listing
            |> JobListing.changeset(params)
            |> Map.put(:action, :insert)

        {:noreply, assign(socket, changeset: changeset)}
    end


    def render(assigns) do
        ~H"""
        <div>
            <h1>Post a Job</h1>
            <.form :let={f} for={@changeset} phx-change="validate" phx-submit="create">
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
