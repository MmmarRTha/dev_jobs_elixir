defmodule DevJobs.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias DevJobs.UserEmail
  alias DevJobs.Repo
  alias DevJobs.Users.User
  alias DevJobs.UserTokens

  def save_user(attrs) do
    if user = find_user(attrs) do
      {:ok, user}
    else
      %User{}
      |> User.changeset(attrs)
      |> Repo.insert()
    end
  end

  def deliver_magic_link(user, magic_link_url) do
    {email_token, user_token} = UserTokens.build_hashed_token(user)
    Repo.insert!(user_token)
    UserEmail.magic_link_email(user, magic_link_url.(email_token))
  end

  defp find_user(%{"email" => email}) do
    Repo.get_by(User, %{email: email})
  end

  defp find_user(_), do: nil
end
