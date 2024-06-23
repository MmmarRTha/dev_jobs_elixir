defmodule DevJobs.UserEmail do
  alias DevJobs.Mailer
  import Swoosh.Email

  @from {"DevJobs", "no-reply@devjobs.com"}

  defp deliver(recipient, subject, body) do
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

  def magic_link_email(user, login_url) do
    deliver(user.email, "Magic link to log in to DevJobs", """
    Hello #{user.email},
    Here you will find a magic link:crypto to login to our DevJobs plataform.

    #{login_url}
    """)
  end
end
