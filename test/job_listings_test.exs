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
    setup do
      # Create test job listings
      {:ok, elixir_job} =
        JobListings.save_job_listing(%DevJobs.JobListings.JobListing{}, %{
          "title" => "Elixir Developer",
          "description" => "Looking for an experienced Elixir developer",
          "location" => "Remote",
          "company" => "Tech Corp",
          "salary" => 100_000
        })

      {:ok, php_job} =
        JobListings.save_job_listing(%DevJobs.JobListings.JobListing{}, %{
          "title" => "PHP Developer",
          "description" => "Senior PHP developer needed",
          "location" => "New York",
          "company" => "Web Solutions",
          "salary" => 80000
        })

      {:ok, frontend_job} =
        JobListings.save_job_listing(%DevJobs.JobListings.JobListing{}, %{
          "title" => "Frontend Developer",
          "description" => "React and JavaScript expert",
          "location" => "San Francisco",
          "company" => "Startup Inc",
          "salary" => 90000
        })

      %{
        elixir_job: elixir_job,
        php_job: php_job,
        frontend_job: frontend_job
      }
    end

    test "lists all job listings when no search params", %{
      elixir_job: elixir_job,
      php_job: php_job,
      frontend_job: frontend_job
    } do
      results = JobListings.list_job_listings(1, %{})
      assert length(results) >= 3

      # Check that our test jobs are in the results
      job_ids = Enum.map(results, & &1.id)
      assert elixir_job.id in job_ids
      assert php_job.id in job_ids
      assert frontend_job.id in job_ids
    end

    test "filters job listings by title search", %{elixir_job: elixir_job} do
      results = JobListings.list_job_listings(1, %{"search_text" => "Elixir"})
      assert length(results) == 1
      assert hd(results).id == elixir_job.id
    end

    test "filters job listings by description search", %{php_job: php_job} do
      results = JobListings.list_job_listings(1, %{"search_text" => "Senior"})
      assert length(results) == 1
      assert hd(results).id == php_job.id
    end

    test "filters job listings by partial text match", %{
      elixir_job: elixir_job,
      frontend_job: frontend_job
    } do
      results = JobListings.list_job_listings(1, %{"search_text" => "Developer"})
      assert length(results) >= 2

      job_ids = Enum.map(results, & &1.id)
      assert elixir_job.id in job_ids
      assert frontend_job.id in job_ids
    end

    test "returns empty list for non-matching search", %{} do
      results = JobListings.list_job_listings(1, %{"search_text" => "NonExistent"})
      assert results == []
    end

    test "search is case insensitive", %{elixir_job: elixir_job} do
      results = JobListings.list_job_listings(1, %{"search_text" => "elixir"})
      assert length(results) == 1
      assert hd(results).id == elixir_job.id
    end

    test "handles empty search text", %{
      elixir_job: elixir_job,
      php_job: php_job,
      frontend_job: frontend_job
    } do
      results = JobListings.list_job_listings(1, %{"search_text" => ""})
      assert length(results) >= 3

      job_ids = Enum.map(results, & &1.id)
      assert elixir_job.id in job_ids
      assert php_job.id in job_ids
      assert frontend_job.id in job_ids
    end
  end

  describe "count_job_listings/1" do
    setup do
      # Create test job listings
      {:ok, _elixir_job} =
        JobListings.save_job_listing(%DevJobs.JobListings.JobListing{}, %{
          "title" => "Elixir Developer",
          "description" => "Looking for an experienced Elixir developer",
          "location" => "Remote",
          "company" => "Tech Corp",
          "salary" => 100_000
        })

      {:ok, _php_job} =
        JobListings.save_job_listing(%DevJobs.JobListings.JobListing{}, %{
          "title" => "PHP Developer",
          "description" => "Senior PHP developer needed",
          "location" => "New York",
          "company" => "Web Solutions",
          "salary" => 80000
        })

      {:ok, _frontend_job} =
        JobListings.save_job_listing(%DevJobs.JobListings.JobListing{}, %{
          "title" => "Frontend Developer",
          "description" => "React and JavaScript expert",
          "location" => "San Francisco",
          "company" => "Startup Inc",
          "salary" => 90000
        })

      :ok
    end

    test "counts all job listings when no search params" do
      count = JobListings.count_job_listings(%{})
      assert count >= 3
    end

    test "counts filtered job listings by search text" do
      count = JobListings.count_job_listings(%{"search_text" => "Developer"})
      assert count >= 3
    end

    test "counts zero for non-matching search" do
      count = JobListings.count_job_listings(%{"search_text" => "NonExistent"})
      assert count == 0
    end

    test "counts one for specific search" do
      count = JobListings.count_job_listings(%{"search_text" => "Elixir"})
      assert count == 1
    end

    test "handles empty search text" do
      count = JobListings.count_job_listings(%{"search_text" => ""})
      assert count >= 3
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
      JobListings.delete_job_listing(saved_job_listing)

      assert_raise Ecto.NoResultsError, fn ->
        JobListings.get_job_listing!(saved_job_listing.id)
      end
    end
  end
end
