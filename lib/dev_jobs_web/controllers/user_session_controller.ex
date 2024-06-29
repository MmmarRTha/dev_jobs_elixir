defmodule DevJobsWeb.UserSessionController do
  use DevJobsWeb, :controller
  alias DevJobs.Users.User
  alias DevJobs.UserTokens

  def index(conn, %{"token" => token}) do
    case UserTokens.get_user_by_email_token(token) do
      %User{} = user ->
        conn
        |> put_flash(:info, "Welcome  #{user.email}, You are now Logged In!")
        |> put_token_in_session(token)
        |> redirect(to: ~p"/")

      _ ->
        conn
        |> put_flash(:error, "Invalid token")
        |> redirect(to: ~p"/")
    end
  end

  def logout(conn, _params) do
    conn
    |> put_flash(:info, "BYE!")
    |> delete_token_from_session()
    |> redirect(to: ~p"/")
  end

  defp put_token_in_session(conn, token) do
    conn
    |> put_session(:user_token, token)
  end

  defp delete_token_from_session(conn) do
    delete_session(conn, :user_token)
  end
end
