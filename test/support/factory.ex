defmodule VisionHub.Factory do
  use ExMachina.Ecto, repo: VisionHub.Repo

  alias Ecto.UUID
  alias VisionHub.Accounts.{Device, User}

  @spec user_factory() :: User.t()
  def user_factory do
    %User{
      email: sequence(:email, &"user#{&1}@example.com"),
      name: "User",
      deactivated_at: nil
    }
  end

  @spec device_factory() :: Device.t()
  def device_factory do
    %Device{
      brand: "Intelbras",
      is_active: true,
      name: "Device",
      user_id: UUID.generate()
    }
  end
end
