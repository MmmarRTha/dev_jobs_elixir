defmodule DevJobs.JobListings.JobListing do
    use Ecto.Schema
    import Ecto.Changeset

    schema "job_listings" do
        field :title, :string
        field :description, :string
        field :location, :string
        field :company, :string
        field :salary, :decimal

        timestamps()
    end

    def changeset(job_listing, attrs \\ %{}) do
        job_listing
        |> cast(attrs, [:title, :description, :location, :company, :salary])
        |> validate_required([:title, :description, :location, :company, :salary])
    end

end
