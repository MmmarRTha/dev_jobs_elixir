defmodule DevJobsWeb.UserAuth do
  alias DevJobs.UserTokens
  use DevJobsWeb, :verified_routes

  import Plug.Conn

  def on_mount(:mount_current_user, _params, session, socket) do
    {:cont, mount_current_user(socket, session)}
  end

  def on_mount(:ensure_authenticated, _params, session, socket) do
    socket = mount_current_user(socket, session)

    if socket.assigns.current_user do
      {:cont, socket}
    else
      socket =
        socket
        |> Phoenix.LiveView.put_flash(:error, "You must be logged in to access this page.")
        |> Phoenix.LiveView.redirect(to: ~p"/")

      {:halt, socket}
    end
  end

  def redirect_if_user_is_authenticated(conn, _opts) do
    if get_session(conn, :user_token) do
      conn
      |> Phoenix.Controller.redirect(to: ~p"/")
      |> halt()
    else
      conn
    end
  end

  defp mount_current_user(socket, session) do
    Phoenix.Component.assign_new(socket, :current_user, fn ->
      if user_token = session["user_token"] do
        UserTokens.get_user_by_email_token(user_token)
      end
    end)
  end
end
