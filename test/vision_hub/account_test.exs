defmodule VisionHub.AccountTest do
  use ExUnit.Case, async: true

  import Ecto.Changeset
  import Ecto.Query

  alias VisionHub.Account
  alias VisionHub.Accounts.User
  alias VisionHub.Repo

  describe "get_users_with_hikvision_devices/0" do
    setup do
      user_1 = insert(:user, email: "user1@example.com")
      insert(:device, user_id: user_1.id, brand: "Hikvision")

      user_2 = insert(:user, email: "user2@example.com")
      insert(:device, user_id: user_2.id, brand: "Samsung")

      user_3 = insert(:user, email: "user3@example.com")
      insert(:device, user_id: user_3.id, brand: "Hikvision")

      {:ok, user_1: user_1, user_2: user_2, user_3: user_3}
    end

    test "should return users with Hikvision devices", %{
      user_1: user_1,
      user_2: user_2,
      user_3: user_3
    } do
      users_with_hikvision = Account.get_users_with_hikvision_devices()

      assert user_1 in users_with_hikvision
      assert user_3 in users_with_hikvision

      refute user_2 in users_with_hikvision
    end

    test "should return empty list when there are no users", _context do
      Repo.delete_all(User)

      users_with_hikvision = Account.get_users_with_hikvision_devices()
      assert users_with_hikvision == []
    end

    test "should return users with Hikvision devices", %{user_1: user_1, user_3: user_3} do
      users_with_hikvision = Account.get_users_with_hikvision_devices()

      assert length(users_with_hikvision) == 2
      assert user_1 in users_with_hikvision
      assert user_3 in users_with_hikvision
    end

    test "should not return user without Hikvision device", %{user_2: user_2} do
      users_with_hikvision = Account.get_users_with_hikvision_devices()

      refute user_2 in users_with_hikvision
    end
  end
end
