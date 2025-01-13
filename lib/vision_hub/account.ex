defmodule VisionHub.Account do
  @moduledoc """
  The Accounts context.

  This module provides functions to interact with user accounts and their associated devices.
  """

  alias VisionHub.Repo
  alias VisionHub.Accounts.User
  alias VisionHub.Filters.DeviceFilters

  import Ecto.Query

  @behaviour VisionHub.AccountBehaviour

  @brand "Hikvision"
  @doc """
  Retrieves all users who have Hikvision devices associated with their accounts.

  ## Examples

      iex> VisionHub.Account.get_users_with_hikvision_devices()
      [%User{}, ...]

  """
  @spec get_users_with_hikvision_devices() :: [User.t()]
  def get_users_with_hikvision_devices do
    Repo.all(
      from u in User,
        join: d in assoc(u, :devices),
        where: d.brand == @brand,
        select: u
    )
  end

  @doc """
  Retrieves active users with devices, applying optional filters for device name, brand, and ordering.

  ## Examples

      iex> VisionHub.Account.get_users_with_devices("Device 1", "Hikvision", "brand")
      [%User{}, ...]

  """
  @spec get_users_with_devices(
          String.t() | nil,
          String.t() | nil,
          String.t() | nil
        ) :: [User.t()]
  def get_users_with_devices(
        device_name_filter \\ nil,
        device_brand_filter \\ nil,
        order_by \\ nil
      ) do
    query =
      User
      |> join(:inner, [u], d in assoc(u, :devices))
      |> where([u, d], d.is_active == true)

    query
    |> DeviceFilters.apply_device_name_filter(device_name_filter)
    |> DeviceFilters.apply_device_brand_filter(device_brand_filter)
    |> DeviceFilters.apply_ordering(order_by)
    |> preload([u, d], devices: d)
    |> Repo.all()
  end
end
