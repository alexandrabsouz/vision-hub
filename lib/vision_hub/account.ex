defmodule VisionHub.Account do
  @moduledoc """
  The Accounts context.

  This module provides functions to interact with user accounts and their associated devices.
  """
  alias VisionHub.Repo
  alias VisionHub.Accounts.User

  import Ecto.Query

  @doc """
  Retrieves all users who have Hikvision devices associated with their accounts.

  ## Examples

      iex> VisionHub.Account.get_users_with_hikvision_devices()
      [%User{}, ...]

  """
  def get_users_with_hikvision_devices do
    Repo.all(
      from u in User,
        join: d in assoc(u, :devices),
        where: d.brand == "Hikvision",
        select: u
    )
  end
end
