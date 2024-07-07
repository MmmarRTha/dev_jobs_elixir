defmodule DevJobs.UserEmailTest do
  use ExUnit.Case
  alias DevJobs.UserEmail

  test "deliver/3 sends email successfully" do
    recipient = "test@example.com"
    subject = "Test Subject"
    body = "Test Body"

    assert {:ok, _} = UserEmail.deliver(recipient, subject, body)
  end

  test "magic_link_email/2 sends email with magic link" do
    user = %DevJobs.Users.User{email: "test@example.com"}
    magic_link_url = "https://example.com/magic-link"

    assert {:ok, _} = UserEmail.magic_link_email(user, magic_link_url)
  end
end
