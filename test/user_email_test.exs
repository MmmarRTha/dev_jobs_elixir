defmodule DevJobs.UserEmailTest do
  use ExUnit.Case
  import Swoosh.TestAssertions
  alias DevJobs.UserEmail

  test "deliver/3 sends email successfully" do
    recipient = "test@example.com"
    subject = "Test Subject"
    body = "Test Body"

    assert {:ok, _} = UserEmail.deliver(recipient, subject, body)

    assert_email_sent(subject: subject, to: [{nil, recipient}])
  end

  test "magic_link_email/2 sends email with magic link" do
    original_resend = System.get_env("RESEND")
    System.delete_env("RESEND")

    user = %DevJobs.Users.User{email: "test@example.com"}
    magic_link_url = "https://example.com/magic-link"

    assert {:ok, _} = UserEmail.magic_link_email(user, magic_link_url)

    assert_email_sent(subject: "Sign in to Dev Jobs", to: [{nil, "test@example.com"}])

    if original_resend, do: System.put_env("RESEND", original_resend)
  end
end
