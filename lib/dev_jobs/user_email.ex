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

      <p style="font-size:16px;line-height:26px;margin:16px 0" >Here you will find a magic link to sign in to our DevJobs platform. </p>

        <a class="text-gray-900 bg-gradient-to-r from-teal-200 via-teal-400 to-teal-500 hover:bg-gradient-to-br focus:ring-4 focus:outline-none focus:ring-teal-300 dark:focus:ring-teal-800 shadow-lg shadow-teal-500/50 dark:shadow-lg dark:shadow-teal-800/80 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2" href="#{magic_link_url}">Click here to Sign In</a>

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
