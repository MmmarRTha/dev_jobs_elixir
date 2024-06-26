defmodule DevJobs.UserTokens do
  @moduledoc """
  The UserTokens context.
  """

  import Ecto.Query, warn: false
  alias DevJobs.Users.UserToken
  alias DevJobs.Repo
  alias DevJobs.Users.User

  @rand_size 32
  @hash_algorithm :sha256
  @magic_link_validate_in_days 1

  def build_hashed_token(user) do
    token = :crypto.strong_rand_bytes(@rand_size)
    hashed_token = :crypto.hash(@hash_algorithm, token)

    {
      Base.url_encode64(token, padding: false),
      %UserToken{
        user_id: user.id,
        token: hashed_token
      }
    }
  end

  def get_user_by_email_token(token) do
    with {:ok, query} <- veryfy_email_token(token),
         %User{} = user <- Repo.one(query) do
      user
    else
      _ -> nil
    end
  end

  def veryfy_email_token(token) do
    case Base.url_decode64(token, padding: false) do
      {:ok, decoded_token} ->
        hashed_token = :crypto.hash(@hash_algorithm, decoded_token)

        query =
          from users_tokens in UserToken,
            join: users in assoc(users_tokens, :user),
            where: users_tokens.token == ^hashed_token,
            where: users_tokens.inserted_at > ago(@magic_link_validate_in_days, "day"),
            select: users

        {:ok, query}

      :error ->
        :error
    end
  end
end
