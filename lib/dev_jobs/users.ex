defmodule DevJobs.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias DevJobs.UserEmail
  alias DevJobs.Repo
  alias DevJobs.Users.User
  alias DevJobs.UserTokens

  @doc """
    Saves a user or returns an existing user.

    ## Examples

        iex> DevJobs.Users.save_user(%{"email" => "email@email.com"})
        {:ok, %User{}}

        iex> DevJobs.Users.save_user(%{"email" => "unknown@example.com"})
        nil
  """
  def save_user(attrs) do
    if user = find_user(attrs) do
      {:ok, user}
    else
      %User{}
      |> User.changeset(attrs)
      |> Repo.insert()
    end
  end

  @doc """
      Delivers a magic link to the user.
  """
  def deliver_magic_link(user, magic_link_url) do
    {email_token, user_token} = UserTokens.build_hashed_token(user)
    Repo.insert!(user_token)
    UserEmail.magic_link_email(user, magic_link_url.(email_token))
  end

  def find_user(%{"email" => email}) do
    Repo.get_by(User, %{email: email})
  end

  def find_user(_), do: nil
end
