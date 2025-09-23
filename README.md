# Dev Jobs Elixir

## About This Repository
Dev Jobs Elixir is a modern job board application built with Elixir and Phoenix LiveView. It provides a seamless, real-time experience for both job seekers and employers. Users can create, read, update, and delete (CRUD) job listings through a secure authentication system using magic links sent via email. The platform features advanced search capabilities and a responsive, user-friendly interface.

## 🛠 Technologies Used 👩🏻‍💻

- **Backend**: Elixir ⚗️ with Phoenix LiveView for real-time updates
- **Frontend**: Tailwind CSS with custom animations and responsive design
- **Database**: PostgreSQL with Ecto as ORM
- **Authentication**: Secure magic link system via Resend Email API
- **Testing**: ExUnit for comprehensive test coverage
- **Build Tool**: Mix (Elixir's build tool)
- **Real-time Features**: Phoenix PubSub for live updates

## 🚦 Getting Started

### Prerequisites ⚙️

- Elixir (version 1.12 or higher)
- Erlang OTP (version 24 or higher)

### Installation 🛠️

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
   
5. Run tests
   ```bash
   mix test
   ```
Visit http://localhost:4000 in your browser to see the application running.

## Features & Usage 🚀

>
> [!NOTE]
> ### For Job Seekers 🔍
> - **Real-time Search**: Dynamic search functionality for jobs by title, company, or keywords
> - **Infinite Scroll**: Seamlessly browse through job listings with automatic loading
> - **Responsive Design**: Optimal viewing experience across all devices
>
> ### For Employers 💼
> - **Secure Authentication**: Simple and secure sign-in via magic link email
> - **Job Management**: Create, edit, and delete job listings with ease
> - **Personal Dashboard**: Track and manage all your job postings in one place
> 
> ### System Features ⚡
> - **Real-time Updates**: Instant notifications when new jobs are posted
> - **Performance Optimized**: Fast loading and smooth interactions
> - **Modern UI**: Clean, intuitive interface with animations and visual feedback
>

## Getting Started with Development 🛠

### System Requirements

```bash
# Minimum versions required
Elixir 1.12+
Erlang OTP 24+
PostgreSQL 12+
Node.js 16+ (for asset compilation)
```

### Environment Setup

1. Clone and install dependencies
   ```bash
   git clone https://github.com/MmmarRTha/dev_jobs_elixir.git
   cd dev_jobs_elixir
   mix deps.get
   ```

2. Configure environment
   - Copy `.env.example` to `.env` (if exists)
   - Set up your database credentials
   - Configure your Resend API key for email functionality

3. Set up the database
   ```bash
   mix ecto.setup   # Creates, migrates, and seeds the database
   ```

4. Start the development server
   ```bash
   mix phx.server   # Starts the Phoenix server
   ```

Visit `http://localhost:4000` to start using the application locally.

## Testing 🧪

Run the test suite with:
```bash
mix test                 # Run all tests
mix test --cover        # Run tests with coverage report
mix test.watch         # Run tests in watch mode (requires mix test.watch)
```
