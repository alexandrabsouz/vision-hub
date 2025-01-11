defmodule VisionHub.Factory do
  use ExMachina.Ecto, repo: VisionHub.Repo

  alias VisionHub.Accounts.{Device, User}

  @spec user_factory() :: User.t()
  def user_factory do
    %User{
      email: sequence(:email, &"user#{&1}@example.com"),
      name: "User"
    }
  end

  @spec device_factory() :: Device.t()
  def device_factory do
    %Device{
      brand: "Intelbras",
      is_active: true,
      name: "Device"
    }
  end
end
