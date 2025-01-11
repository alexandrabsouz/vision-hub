defmodule VisionHubWeb.DeviceController do
  @moduledoc """
  Controller for managing devices related to users.

  Provides an API to fetch active users and their devices with optional filters.
  """
  use VisionHubWeb, :controller

  alias VisionHub.Account

  @doc """
  Fetches active users with their devices.

  Accepts optional query parameters:
    - `name`: Filter devices by name.
    - `brand`: Filter devices by brand.
    - `order_by`: Sort results by 'name' or 'brand'.

  ## Parameters
    - `conn`: Connection data.
    - `params`: Query parameters for filtering and sorting.

  ## Response
    JSON with users and their filtered devices.
  """
  def index(conn, params) do
    users_with_devices =
      Account.get_users_with_devices(
        Map.get(params, "name"),
        Map.get(params, "brand"),
        Map.get(params, "order_by")
      )

    json(conn, %{users: users_with_devices})
  end
end
