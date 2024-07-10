defmodule DevJobs.UserEmail do
  alias DevJobs.Mailer
  import Swoosh.Email

  @from "Dev Jobs <noreply@devjob-elixir.me>"

  defp deliver(recipient, subject, body_email) do
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

    <p style="font-size:16px;line-height:26px;margin:16px 0">Here you will find a magic link to sign in to our DevJobs platform.</p>

    <p style="font-size:16px;line-height:26px;margin:16px 0"><a href="#{magic_link_url}" style="color:#FF6363;text-decoration:none" target="_blank">👉 Click here to sign in 👈</a></p>
    <p style="font-size:16px;line-height:26px;margin:16px 0">If you didn&#x27;t request this, please ignore this email.</p>

    """
  end

  defp send_email_using_resend(%{user: user, subject: subject, body_email: body_email}) do
    client = Resend.client(api_key: "re_65NjJqey_GWbpGHzEXXboKYp8RSGdFsfe")

    Resend.Emails.send(client, %{
      from: @from,
      to: [user.email],
      subject: subject,
      html: body_email
    })
  end
end
