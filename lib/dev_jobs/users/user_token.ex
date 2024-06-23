defmodule DevJobs.Users.UserToken do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users_tokens" do
    field :token, :binary
    belongs_to :user, DevJobs.Users.User

    timestamps(updated_at: false)
  end

  def changeset(user_token, attrs \\ %{}) do
    user_token
    |> cast(attrs, [:token, :user_id])
    |> validate_required([:token, :user_id])
  end
end
