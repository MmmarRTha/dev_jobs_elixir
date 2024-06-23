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

  def magic_link_email(user, magic_link_url) do
    deliver(user.email, "Magic link to log in to DevJobs", """
    Hello #{user.email},
    Here you will find a magic link to login to our DevJobs platform.

    <div class="shadow-2xl">
        <a class="px-4 py-2 font-bold text-white rounded-md bg-fuchsia-500 hover:bg-fuchsia-600" href="#{magic_link_url}">Click here to login</a>
    </div>
    """)
  end
end
