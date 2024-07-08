defmodule DevJobsWeb.UserProfileLive do
  alias DevJobs.Users
  use DevJobsWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> allow_upload(:files, accept: ~w(.jpg .jpeg .png), max_entries: 1)}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :files, ref)}
  end

  def handle_event("save", _params, socket) do
    case consume_files(socket) do
      [file_name | _] ->
        Users.update_user(socket.assigns.current_user, %{"avatar" => file_name})

        IO.inspect("XXXXXXXXXX")
        IO.inspect(socket.assigns.current_user)

        socket =
          socket
          |> put_flash(:info, "Avatar updated")
          |> push_navigate(to: ~p"/my-profile")

        {:noreply, socket}

      _ ->
        {:noreply, put_flash(socket, :error, "There was an error updating your avatar")}
    end
  end

  defp consume_files(socket) do
    consume_uploaded_entries(socket, :files, fn %{path: path}, _entry ->
      file_name = Ecto.UUID.generate()

      dest = Path.join(Application.app_dir(:dev_jobs, "priv/static/uploads"), file_name)

      File.cp!(path, dest)
      {:ok, file_name}
    end)
  end

  defp error_to_string(:too_large), do: "Too large"
  defp error_to_string(:not_accepted), do: "You have selected an unacceptable file type"
  defp error_to_string(:too_many_files), do: "You have selected too many files"
end
