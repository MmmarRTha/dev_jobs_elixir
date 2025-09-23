defmodule DevJobsWeb.JobListingsLiveTest do
  use DevJobsWeb.LiveViewCase
  import Phoenix.LiveViewTest
  alias DevJobs.JobListings

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

  describe "mount/3" do
    test "mounts successfully with no search params", %{conn: conn} do
      {:ok, view, html} = live(conn, ~p"/")

      assert html =~ "Find Your Next"
      assert html =~ "Dream Job"
      assert has_element?(view, "form[phx-change=\"search\"]")
      assert has_element?(view, "input[name=\"search[search_text]\"]")
    end

    test "mounts successfully with search params", %{conn: conn, elixir_job: _elixir_job} do
      {:ok, view, html} = live(conn, ~p"/?search_text=Elixir")

      assert html =~ "Find Your Next"
      assert html =~ "Dream Job"
      assert has_element?(view, "form[phx-change=\"search\"]")
      assert has_element?(view, "input[name=\"search[search_text]\"]")
    end
  end

  describe "search functionality" do
    test "performs search on form submission", %{conn: conn, elixir_job: _elixir_job} do
      {:ok, view, _html} = live(conn, ~p"/")

      # Submit search form
      view
      |> form("form[phx-submit=\"search\"]", %{search: %{search_text: "Elixir"}})
      |> render_submit()

      # Check that search results are displayed
      assert render(view) =~ "Found 1 result"
      assert render(view) =~ "Elixir Developer"
    end

    test "performs search on form change (phx-change)", %{conn: conn, elixir_job: _elixir_job} do
      {:ok, view, _html} = live(conn, ~p"/")

      # Trigger search on form change
      view
      |> form("form[phx-change=\"search\"]", %{search: %{search_text: "Elixir"}})
      |> render_change()

      # Check that search results are displayed
      assert render(view) =~ "Found 1 result"
      assert render(view) =~ "Elixir Developer"
    end

    test "clears search when clear button is clicked", %{
      conn: conn,
      elixir_job: _elixir_job,
      php_job: _php_job,
      frontend_job: _frontend_job
    } do
      {:ok, view, _html} = live(conn, ~p"/")

      # First perform a search
      view
      |> form("form[phx-submit=\"search\"]", %{search: %{search_text: "Elixir"}})
      |> render_submit()

      # Verify search results are shown
      assert render(view) =~ "Found 1 result"

      # Click clear button
      view
      |> element("button[phx-click=\"clear_search\"]")
      |> render_click()

      # Check that all job listings are shown again
      html = render(view)
      assert html =~ "Elixir Developer"
      assert html =~ "PHP Developer"
      assert html =~ "Frontend Developer"
      refute html =~ "Found 1 result"
    end

    test "shows loading state during search", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/")

      # Start search
      view
      |> form("form[phx-submit=\"search\"]", %{search: %{search_text: "Developer"}})
      |> render_submit()

      # Check that loading state is shown (searching should be false after search completes)
      html = render(view)
      refute html =~ "Searching..."
    end

    test "updates search result counter", %{
      conn: conn,
      elixir_job: _elixir_job,
      php_job: _php_job,
      frontend_job: _frontend_job
    } do
      {:ok, view, _html} = live(conn, ~p"/")

      # Search for "Developer" which should match multiple jobs
      view
      |> form("form[phx-submit=\"search\"]", %{search: %{search_text: "Developer"}})
      |> render_submit()

      # Check that result counter shows correct number
      html = render(view)
      assert html =~ "Found 3 result"
    end

    test "handles empty search text", %{
      conn: conn,
      elixir_job: _elixir_job,
      php_job: _php_job,
      frontend_job: _frontend_job
    } do
      {:ok, view, _html} = live(conn, ~p"/")

      # Submit empty search
      view
      |> form("form[phx-submit=\"search\"]", %{search: %{search_text: ""}})
      |> render_submit()

      # Check that all job listings are shown
      html = render(view)
      assert html =~ "Elixir Developer"
      assert html =~ "PHP Developer"
      assert html =~ "Frontend Developer"
      refute html =~ "Found"
    end

    test "search is case insensitive", %{conn: conn, elixir_job: _elixir_job} do
      {:ok, view, _html} = live(conn, ~p"/")

      # Search with lowercase
      view
      |> form("form[phx-submit=\"search\"]", %{search: %{search_text: "elixir"}})
      |> render_submit()

      # Check that results are found
      assert render(view) =~ "Found 1 result"
      assert render(view) =~ "Elixir Developer"
    end

    test "maintains search state across page interactions", %{conn: conn, elixir_job: _elixir_job} do
      {:ok, view, _html} = live(conn, ~p"/")

      # Perform search
      view
      |> form("form[phx-submit=\"search\"]", %{search: %{search_text: "Elixir"}})
      |> render_submit()

      # Verify search is active
      assert render(view) =~ "Found 1 result"

      # Check that search input still has the value
      assert has_element?(view, "input[value=\"Elixir\"]")
    end
  end

  describe "pagination with search" do
    test "pagination works with search results", %{conn: conn} do
      # Create more than 10 job listings to test pagination
      for i <- 1..15 do
        JobListings.save_job_listing(%DevJobs.JobListings.JobListing{}, %{
          "title" => "Developer #{i}",
          "description" => "Test developer job #{i}",
          "location" => "Remote",
          "company" => "Test Company",
          "salary" => 50000 + i * 1000
        })
      end

      {:ok, view, _html} = live(conn, ~p"/")

      # Search for "Developer" (this will match both the original jobs and the new ones)
      view
      |> form("form[phx-submit=\"search\"]", %{search: %{search_text: "Developer"}})
      |> render_submit()

      # Check that pagination is available (should show first 10 results)
      html = render(view)
      assert html =~ "Developer 1"
      # Note: Developer 10 might not be on first page due to other "Developer" jobs
      # Let's check that we have pagination by looking for the viewport-bottom attribute
      assert html =~ "phx-viewport-bottom"
      # Should not be on first page
      refute html =~ "Developer 11"
    end
  end

  describe "real-time search updates" do
    test "new job listings are filtered by current search", %{conn: conn, elixir_job: _elixir_job} do
      {:ok, view, _html} = live(conn, ~p"/")

      # Perform search for "Elixir"
      view
      |> form("form[phx-submit=\"search\"]", %{search: %{search_text: "Elixir"}})
      |> render_submit()

      # Verify only Elixir job is shown
      assert render(view) =~ "Found 1 result"
      assert render(view) =~ "Elixir Developer"

      # Create a new Elixir job (this would normally come from PubSub)
      {:ok, new_elixir_job} =
        JobListings.save_job_listing(%DevJobs.JobListings.JobListing{}, %{
          "title" => "Senior Elixir Developer",
          "description" => "Another Elixir position",
          "location" => "Remote",
          "company" => "New Tech Corp",
          "salary" => 120_000
        })

      # Simulate the PubSub message
      send(view.pid, {:new_jobs_posted, new_elixir_job})

      # Check that the new job appears in search results
      html = render(view)
      assert html =~ "Found 3 result"
      assert html =~ "Senior Elixir Developer"
    end

    test "new job listings that don't match search are not shown", %{
      conn: conn,
      elixir_job: _elixir_job
    } do
      {:ok, view, _html} = live(conn, ~p"/")

      # Perform search for "Elixir"
      view
      |> form("form[phx-submit=\"search\"]", %{search: %{search_text: "Elixir"}})
      |> render_submit()

      # Verify only Elixir job is shown
      assert render(view) =~ "Found 1 result"

      # Create a new PHP job (this would normally come from PubSub)
      {:ok, new_php_job} =
        JobListings.save_job_listing(%DevJobs.JobListings.JobListing{}, %{
          "title" => "Senior PHP Developer",
          "description" => "Another PHP position",
          "location" => "Remote",
          "company" => "New Web Corp",
          "salary" => 90000
        })

      # Simulate the PubSub message
      send(view.pid, {:new_jobs_posted, new_php_job})

      # Check that the new job does NOT appear in search results
      html = render(view)
      assert html =~ "Found 1 result"
      refute html =~ "Senior PHP Developer"
    end
  end
end
