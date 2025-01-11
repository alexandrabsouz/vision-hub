defmodule VisionHubWeb.UserController do
  @moduledoc """
  The UserController handles user-related actions such as notifying users with Hikvision devices.
  """
  use VisionHubWeb, :controller

  alias VisionHub.Account
  alias VisionHub.Mailer

  @doc """
  Notifies users with Hikvision devices by sending them an email notification.

  ## Parameters
    - conn: The connection struct.
    - _params: The request parameters (not used in this function).

  ## Description
  This function retrieves users who have Hikvision devices and sends them notification emails concurrently.
  It uses `Task.async_stream/3` to send emails with a maximum concurrency of 10 tasks at a time.
  After all tasks are completed, it sets the HTTP status to `:ok` and returns a JSON response indicating that users have been notified.

  ## Response
    - HTTP Status: 200 OK
    - JSON Body: %{message: "Users notified"}
  """
  def notify_users(conn, _params) do
    users = Account.get_users_with_hikvision_devices()

    tasks = Task.async_stream(users, fn user ->
      Mailer.send_notification_email(user.email)
    end, max_concurrency: 10)

    Task.await_many(tasks)
    Enum.each(tasks, fn {:ok, _result} -> :ok end)

    conn
    |> put_status(:ok)
    |> json(%{message: "Users notified"})
  end
end
