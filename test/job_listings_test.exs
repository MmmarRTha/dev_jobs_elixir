defmodule DevJobs.JobListingsTest do
  use ExUnit.Case, async: true
  alias DevJobs.JobListings

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(DevJobs.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(DevJobs.Repo, {:shared, self()})
    :ok
  end

  describe "save_job_listing/2" do
    test "saves a new job listing" do
      job_listing = %DevJobs.JobListings.JobListing{}

      attrs = %{
        "title" => "Test Job",
        "description" => "Test Description",
        "location" => "Test Location",
        "company" => "Test Company",
        "salary" => 95000
      }

      {:ok, job_listing} = JobListings.save_job_listing(job_listing, attrs)
      assert job_listing.title == attrs["title"]
      assert job_listing.description == attrs["description"]
      assert job_listing.location == attrs["location"]
      assert job_listing.company == attrs["company"]
      assert job_listing.salary == Decimal.new(attrs["salary"])
    end
  end

  describe "get_job_listing!/1" do
    test "gets a job listing by id" do
      job_listing = %DevJobs.JobListings.JobListing{}

      attrs = %{
        "title" => "Test Job",
        "description" => "Test Description",
        "location" => "Test Location",
        "company" => "Test Company",
        "salary" => 95000
      }

      {:ok, job_listing} = JobListings.save_job_listing(job_listing, attrs)

      assert JobListings.get_job_listing!(job_listing.id) == job_listing
    end
  end

  describe "list_job_listings/2" do
    test "lists job listings" do
      job_listing = %DevJobs.JobListings.JobListing{}

      attrs = %{
        "title" => "Test Job",
        "description" => "Test Description",
        "location" => "Test Location",
        "company" => "Test Company",
        "salary" => 95000
      }

      {:ok, job_listing} = JobListings.save_job_listing(job_listing, attrs)

      assert JobListings.list_job_listings(1, %{"search_text" => "Test"}) == [job_listing]
    end
  end

  describe "list_my_job_listings/2" do
    test "lists job listings for a user" do
    end
  end

  describe "delete_job_listing/1" do
    setup do
      job_listing = %DevJobs.JobListings.JobListing{}

      attrs = %{
        "title" => "Test Job",
        "description" => "Test Description",
        "location" => "Test Location",
        "company" => "Test Company",
        "salary" => 95000,
        "user_id" => 1
      }

      {:ok, saved_job_listing} = JobListings.save_job_listing(job_listing, attrs)
      %{job_listing: saved_job_listing}
    end

    test "deletes a job listing", %{job_listing: saved_job_listing} do
      JobListings.delete_job_listing(saved_job_listing.id)

      assert_raise Ecto.NoResultsError, fn ->
        JobListings.get_job_listing!(saved_job_listing.id)
      end
    end
  end
end
