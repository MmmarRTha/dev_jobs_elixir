# Dev Jobs Elixir

## About This Repository
Dev Jobs Elixir is a job board application built with Elixir and Phoenix LiveView. It allows users to create, read, update, and delete (CRUD) job listings by signing in with a magic link sent via email. Users can also search for job posts by title and description.

## 🛠 Technologies Used

- **Language**: Elixir Phoenix LiveView, Tailwind CSS
- **Deployment Plataform**: Gigalixir
- **Build Tool**: Mix
- **Testing**: ExUnit
- **Magic Link Authentication Email**: Resend Email API

## 🚦 Getting Started

### Prerequisites

- Elixir (version 1.12 or higher)
- Erlang OTP (version 24 or higher)

### Installation

1. Clone the repository
   ```bash
   git clone https://github.com/MmmarRTha/dev_jobs_elixir.git
   cd dev_jobs_elixir
   ```

2. Install dependencies
   ```bash
   mix deps.get
   ```

3. Set up the database
   ```bash
   mix ecto.setup
   ```

4. Start the Phoenix server
   ```bash
   mix phx.server
   ```
Visit http://localhost:4000 in your browser to see the application running.
5. Run tests
   ```bash
   mix test

## 🤔 How to Use
> [!NOTE]
> Sign In: Enter your email to receive a magic link for authentication.

> Create Job Listing: Fill out the form to create a new job listing.

> Search Jobs: Use the search bar to find job posts by title or description.

> Edit/Delete Jobs: Manage your job listings by editing or deleting them.
