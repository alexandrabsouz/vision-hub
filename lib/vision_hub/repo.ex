defmodule VisionHub.Repo do
  use Ecto.Repo,
    otp_app: :vision_hub,
    adapter: Ecto.Adapters.Postgres
end
