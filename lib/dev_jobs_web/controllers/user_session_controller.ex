defmodule DevJobsWeb.UserSessionController do
  use DevJobsWeb, :controller
  alias DevJobs.Users.User
  alias DevJobs.UserTokens

  def index(conn, %{"token" => token}) do
    case UserTokens.get_user_by_email_token(token) do
      %User{} = user ->
        conn
        |> put_flash(:info, "Welcome  #{user.email}, You are now Logged In!")
        |> redirect(to: ~p"/")

      _ ->
        conn
        |> put_flash(:error, "Invalid token")
        |> redirect(to: ~p"/")
    end
end
end
