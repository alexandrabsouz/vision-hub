defmodule VisionHub.AccountTest do
  use VisionHub.DataCase

  import VisionHub.Factory

  alias VisionHub.Account
  alias VisionHub.Accounts.User
  alias VisionHub.Repo

  describe "get_users_with_hikvision_devices/0" do
    setup do
      user1 = insert(:user, email: "user1@example.com")
      insert(:device, user_id: user1.id, brand: "Hikvision")

      user2 = insert(:user, email: "user2@example.com")
      insert(:device, user_id: user2.id, brand: "Samsung")

      user3 = insert(:user, email: "user3@example.com")
      insert(:device, user_id: user3.id, brand: "Hikvision")

      {:ok, user1: user1, user2: user2, user3: user3}
    end

    # test "should return users with Hikvision devices", %{
    #   user1: user1,
    #   user2: user2,
    #   user3: user3
    # } do
    #   users_with_hikvision = Account.get_users_with_hikvision_devices()

    #   users_with_hikvision = Repo.preload(users_with_hikvision, :devices)

    #   assert user1 in users_with_hikvision
    #   assert user3 in users_with_hikvision
    #   refute user2 in users_with_hikvision
    # end

    test "should return empty list when there are no users", _context do
      Repo.delete_all(User)

      users_with_hikvision = Account.get_users_with_hikvision_devices()
      assert users_with_hikvision == []
    end

    test "should not return user without Hikvision device", %{user2: user2} do
      users_with_hikvision = Account.get_users_with_hikvision_devices()

      users_with_hikvision = Repo.preload(users_with_hikvision, :devices)

      refute user2 in users_with_hikvision
    end
  end

  describe "get_active_users_with_devices/3" do
    setup do
      user1 = insert(:user, email: "user1@example.com", is_active: true)
      user2 = insert(:user, email: "user2@example.com", is_active: false)
      user3 = insert(:user, email: "user3@example.com", is_active: true)

      device1 = insert(:device, user_id: user1.id, brand: "Hikvision", name: "Device Room")
      device2 = insert(:device, user_id: user3.id, brand: "Hikvision", name: "Device Job")
      insert(:device, user_id: user2.id, brand: "Samsung", name: "Device Home")

      {:ok, user1: user1, user2: user2, user3: user3, device1: device1, device2: device2}
    end

    test "should return active users with devices matching filters", %{
      user1: user1,
      device1: device1
    } do
      users_with_devices =
        Account.get_active_users_with_devices(device1.name, device1.brand, "name")

      users_with_devices = Repo.preload(users_with_devices, :devices)

      assert Enum.any?(users_with_devices, fn u -> u.email == user1.email end)

      assert Enum.any?(users_with_devices, fn u ->
               Enum.any?(u.devices, &(&1.name == device1.name))
             end)
    end

    test "should return empty list when no active users match filters", _context do
      users_with_devices =
        Account.get_active_users_with_devices("Nonexistent", "Hikvision", "name")

      users_with_devices = Repo.preload(users_with_devices, :devices)

      assert users_with_devices == []
    end

    test "should return active users with devices by name filter", %{user1: user1, user3: user3} do
      users_with_devices = Account.get_active_users_with_devices("Device Job", nil, nil)

      users_with_devices = Repo.preload(users_with_devices, :devices)

      refute Enum.any?(users_with_devices, fn u -> u.email == user1.email end)
      assert Enum.any?(users_with_devices, fn u -> u.email == user3.email end)
    end

    test "should return active users with devices by brand filter", %{
      user1: user1,
      user3: user3,
      device1: device1,
      device2: device2
    } do
      users_with_devices = Account.get_active_users_with_devices(nil, "Hikvision", nil)

      users_with_devices = Repo.preload(users_with_devices, :devices)

      assert Enum.any?(users_with_devices, fn u ->
               u.email == user1.email && Enum.any?(u.devices, &(&1.name == device1.name))
             end)

      assert Enum.any?(users_with_devices, fn u ->
               u.email == user3.email && Enum.any?(u.devices, &(&1.name == device2.name))
             end)
    end

    test "should return active users with devices by ordering" do
      users_with_devices = Account.get_active_users_with_devices(nil, nil, "name")

      users_with_devices = Repo.preload(users_with_devices, :devices)

      device_names =
        Enum.map(users_with_devices, fn u -> Enum.map(u.devices, & &1.name) end) |> List.flatten()

      sorted_device_names = Enum.sort(device_names)

      assert device_names == sorted_device_names
    end

    test "should return only active users", %{user2: user2} do
      users_with_devices = Account.get_active_users_with_devices(nil, nil, nil)

      users_with_devices = Repo.preload(users_with_devices, :devices)

      refute Enum.any?(users_with_devices, fn u -> u.email == user2.email end)
    end

    test "should return all active users when no filters are applied", %{
      user1: user1,
      user3: user3,
      device1: device1,
      device2: device2
    } do
      users_with_devices = Account.get_active_users_with_devices(nil, nil, nil)

      users_with_devices = Repo.preload(users_with_devices, :devices)

      assert Enum.any?(users_with_devices, fn u ->
               u.email == user1.email && Enum.any?(u.devices, &(&1.name == device1.name))
             end)

      assert Enum.any?(users_with_devices, fn u ->
               u.email == user3.email && Enum.any?(u.devices, &(&1.name == device2.name))
             end)
    end
  end
end
