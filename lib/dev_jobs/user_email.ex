defmodule DevJobs.UserEmail do
  alias DevJobs.Mailer
  import Swoosh.Email

  @from {"DevJobs", "no-reply@devjobs.com"}

  def deliver(recipient, subject, body) do
    email =
      new()
      |> to(recipient)
      |> from(@from)
      |> subject(subject)
      |> text_body(body)

    with {:ok, _metadata} = Mailer.deliver(email) do
      {:ok, recipient}
    end
  end

  def magic_link_email(user, magic_link_url) do
    deliver(user.email, "Magic link to sign in to DevJobs", """
    Hello #{user.email},
    Here you will find a magic link to sign in to our DevJobs platform.

    <div class="">
        <a class="text-gray-900 bg-gradient-to-r from-teal-200 via-teal-400 to-teal-500 hover:bg-gradient-to-br focus:ring-4 focus:outline-none focus:ring-teal-300 dark:focus:ring-teal-800 shadow-lg shadow-teal-500/50 dark:shadow-lg dark:shadow-teal-800/80 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2" href="#{magic_link_url}">Click here to Sign In</a>
    </div>
    """)
  end
end
