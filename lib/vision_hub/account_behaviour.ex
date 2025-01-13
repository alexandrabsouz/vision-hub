defmodule VisionHub.AccountBehaviour do
  @moduledoc """
  This module defines the behaviour for account-related operations.
  """
  @callback get_users_with_hikvision_devices() :: list(any)
end
