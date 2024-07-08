defmodule DevJobs.UsersTest do
  use ExUnit.Case
  alias DevJobs.Users
  alias DevJobs.Users.User
  alias DevJobs.Repo

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(DevJobs.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(DevJobs.Repo, {:shared, self()})
    :ok
    {:ok, user} = Repo.insert(%User{email: "test@example.com"})
    {:ok, user: user}
  end

  describe "save_user/1" do
    test "saves a new user", %{user: user} do
      assert user.id
      assert user.email
    end

    test "returns an existing user" do
      attrs = %{"email" => "existing_user@example.com"}
      {:ok, existing_user} = Users.save_user(attrs)

      {:ok, user} = Users.save_user(attrs)
      assert user.id == existing_user.id
      assert user.email == attrs["email"]
    end
  end

  describe "find_user/1" do
    test "finds a user by email" do
      attrs = %{"email" => "existing_user@example.com"}
      {:ok, user} = Users.save_user(attrs)

      assert Users.find_user(attrs) == user
    end

    test "returns nil if user not found" do
      attrs = %{"email" => "unknown@example.com"}
      assert Users.find_user(attrs) == nil
    end
  end

  describe "update_user/2" do
    test "updates the user with the given attributes", %{user: user} do
      assert {:ok, user_updated} = Users.update_user(user, %{"avatar" => "avatar.png"})

      assert user_updated.avatar == "avatar.png"
    end
  end
end
