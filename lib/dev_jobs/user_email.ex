defmodule DevJobs.UserEmail do
  alias DevJobs.Mailer
  import Swoosh.Email

  @from {"DevJobs", "no-reply@resend.dev"}

  def deliver(recipient, subject, body_email) do
    email =
      new()
      |> to(recipient)
      |> from(@from)
      |> subject(subject)
      |> html_body(body_email)

    with {:ok, _metadata} = Mailer.deliver(email) do
      {:ok, recipient}
    end
  end

  def magic_link_email(user, magic_link_url) do
    subject = "Sign in to DevJobs"
    body_email = email_body(user, magic_link_url)

    if System.get_env("RESEND_API_KEY") do
      send_email_using_resend(%{user: user, subject: subject, body_email: body_email})
    else
      deliver(user.email, subject, body_email)
    end
  end

  def email_body(user, magic_link_url) do
    """
    Hello #{user.email}

    Here you will find a magic link to sign in to our DevJobs platform.

    #{magic_link_url}

    If you didn't request this, please ignore this email.

    """
  end

  defp send_email_using_resend(%{user: user, subject: subject, body_email: body_email}) do
    client = Resend.client(api_key: "RESEND_API_KEY")

    Resend.Emails.send(client, %{
      from: @from,
      to: [user.email],
      subject: subject,
      html: body_email
    })
  end
end
