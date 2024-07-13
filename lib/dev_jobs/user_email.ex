defmodule DevJobs.UserEmail do
  alias DevJobs.Mailer
  import Swoosh.Email

  @from "Dev Jobs <noreply@devjob-elixir.me>"

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
    subject = "Sign in to Dev Jobs"
    body = email_body(user, magic_link_url)

    if System.get_env("RESEND") do
      send_email_using_resend(%{user: user, subject: subject, body_email: body})
    else
      deliver(user.email, subject, body)
    end
  end

  def email_body(user, magic_link_url) do
    """
    <p style="color:black;font-size:16px;line-height:26px;margin:16px 0">Hello #{user.email}</p>
    <p style="color:black;font-size:16px;line-height:26px;margin:16px 0">Here you will find a magic link to sign in to our Dev Jobs platform.</p>

    <h1 style="color:black;font-size:28px;font-weight:bold;margin-top:20px"><a href=" #{magic_link_url}" target="_blank">🪄 Your magic link</a></h1>

    <p style="color:black;font-size:16px;line-height:26px;margin:16px 0">If you didn&#x27;t request this, please ignore this email.</p>
    """
  end

  defp send_email_using_resend(%{user: user, subject: subject, body_email: body_email}) do
    client = Resend.client(api_key: System.get_env("RESEND"))

    Resend.Emails.send(client, %{
      from: @from,
      to: [user.email],
      subject: subject,
      html: body_email
    })
  end
end
