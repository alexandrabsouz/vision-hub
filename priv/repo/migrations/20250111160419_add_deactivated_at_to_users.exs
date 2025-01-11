defmodule VisionHub.Repo.Migrations.AddDeactivatedAtToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :deactivated_at, :utc_datetime, null: true
    end
  end
end
