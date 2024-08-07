defmodule DevJobs.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :avatar, :string

    has_many :job_listings, DevJobs.JobListings.JobListing
    timestamps()
  end

  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end

  def avatar_changeset(user, attrs \\ %{}), do: cast(user, attrs, [:avatar])
end
