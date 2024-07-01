defmodule DevJobs.JobListings.JobListing do
  use Ecto.Schema
  import Ecto.Changeset

  schema "job_listings" do
    field :title, :string
    field :description, :string
    field :location, :string
    field :company, :string
    field :salary, :decimal

    belongs_to :user, DevJobs.Users.User

    timestamps()
  end

  def changeset(job_listing, attrs \\ %{}) do
    job_listing
    |> cast(attrs, [:title, :description, :location, :company, :salary])
    |> validate_required([:title, :description, :location, :company, :salary])
    |> assoc_constraint(:user)
  end
end
