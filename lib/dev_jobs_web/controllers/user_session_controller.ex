defmodule DevJobsWeb.UserSessionController do
  use DevJobsWeb, :controller

  def index(conn, %{"token" => token}) do
    conn
    |> put_flash(:info, "You are now logged in! #{token}")
    |> redirect(to: ~p"/")
  end
end
