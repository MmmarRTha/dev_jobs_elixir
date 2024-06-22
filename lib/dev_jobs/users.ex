defmodule DevJobs.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias DevJobs.Repo
  alias DevJobs.Users.User

  def save_user(attrs) do
    if user = find_user(attrs) do
      {:ok, user}
    else
      %User{}
      |> User.changeset(attrs)
      |> Repo.insert()
    end
  end

  defp find_user(%{email: _email} = attrs) do
    Repo.get_by(User, attrs)
  end

  defp find_user(_), do: nil
end
