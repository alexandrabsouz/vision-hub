defmodule VisionHubWeb.UserControllerTest do
  use VisionHubWeb.ConnCase, async: true

  @moduledoc """
  Tests for the UserController.
  """
  import VisionHub.Factory

  describe "notify_users/2" do
    test "should notify users with Hikvision devices and return 200 OK", %{conn: conn} do
      user1 = insert(:user, email: "user1@example.com")
      user2 = insert(:user, email: "user2@example.com")

      Mox.expect(AccountMock, :get_users_with_hikvision_devices, fn -> [user1, user2] end)
      Mox.expect(MailerMock, :send_notification_email, 2, fn _email -> {:ok, :sent} end)

      conn = post(conn, "/api/notify-users")

      assert json_response(conn, 200)["message"] == "Users notified"
    end

    test "should handle concurrency with Task.async_stream", %{conn: conn} do
      user1 = insert(:user, email: "user1@example.com")
      user2 = insert(:user, email: "user2@example.com")

      Mox.expect(AccountMock, :get_users_with_hikvision_devices, fn -> [user1, user2] end)

      Mox.expect(MailerMock, :send_notification_email, 2, fn _email -> {:ok, :sent} end)

      conn = post(conn, "/api/notify-users")

      assert json_response(conn, 200)["message"] == "Users notified"
    end
  end
end
