defmodule VisionHub.Factory do
  use ExMachina.Ecto, repo: VisionHub.Repo

  def user_factory do
    %VisionHub.Accounts.User{
      email: sequence(:email, &"user#{&1}@example.com")
    }
  end

  def device_factory do
    %VisionHub.Accounts.Device{
      brand: "Hikvision",
      user: build(:user)
    }
  end
end
