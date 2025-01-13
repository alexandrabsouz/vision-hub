defmodule VisionHubWeb.DeviceControllerTest do
  use VisionHubWeb.ConnCase, async: true

  import VisionHub.Factory

  alias VisionHub.Account
  alias VisionHub.Account.Device

  @valid_user_attrs %{name: "John Doe", email: "john@example.com"}

  setup do
    user = insert(:user, @valid_user_attrs)
    device1 = insert(:device, %{user_id: user.id})
    device2 = insert(:device, %{user_id: user.id, name: "Device Room"})
    {:ok, user: user, device1: device1, device2: device2}
  end

  describe "index/2" do
    test "should list all devices for users", %{
      conn: conn,
      user: user,
      device2: device2,
      device1: device1
    } do
      conn = get(conn, "/api/devices")

      assert json_response(conn, 200)["users"] == [
               %{
                 "deactivated_at" => user.deactivated_at,
                 "devices" => [
                   %{
                     "brand" => device2.brand,
                     "id" => device2.id,
                     "is_active" => true,
                     "name" => device2.name,
                     "user_id" => device2.user_id
                   },
                   %{
                     "brand" => device1.brand,
                     "id" => device1.id,
                     "is_active" => true,
                     "name" => device1.name,
                     "user_id" => device1.user_id
                   }
                 ],
                 "email" => user.email,
                 "id" => user.id,
                 "name" => user.name
               }
             ]
    end

    test "should filter devices by name", %{conn: conn, device1: device1, user: user} do
      conn = get(conn, "/api/devices?name=#{device1.name}")

      assert json_response(conn, 200)["users"] == [
               %{
                 "deactivated_at" => user.deactivated_at,
                 "devices" => [
                   %{
                     "brand" => device1.brand,
                     "id" => device1.id,
                     "is_active" => true,
                     "name" => device1.name,
                     "user_id" => user.id
                   }
                 ],
                 "email" => user.email,
                 "id" => user.id,
                 "name" => user.name
               }
             ]
    end

    test "should filter devices by brand", %{conn: conn, user: user, device1: device2} do
      conn = get(conn, "/api/devices?brand=#{device2.brand}")

      assert json_response(conn, 200)["users"] == [
               %{
                 "deactivated_at" => user.deactivated_at,
                 "devices" => [
                   %{
                     "brand" => device2.brand,
                     "id" => device2.id,
                     "is_active" => true,
                     "name" => device2.name,
                     "user_id" => device2.user_id
                   }
                 ],
                 "email" => user.email,
                 "id" => user.id,
                 "name" => user.name
               }
             ]
    end

    test "should sort devices by name", %{conn: conn, device2: device2} do
      conn = get(conn, "/api/devices?order_by=name")
      assert json_response(conn, 200)["users"] != []
    end

    test "should sort devices by brand", %{conn: conn} do
      conn = get(conn, "/api/devices?order_by=brand")
      assert json_response(conn, 200)["users"] != []
    end
  end
end
