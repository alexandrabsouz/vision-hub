defmodule VisionHub.Repo.Migrations.CreateDevicesTable do
  @moduledoc """
  This migration creates the devices table with references to the users table.
  """
  use Ecto.Migration

  def change do
    create table(:devices, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :brand, :string, null: false
      add :is_active, :boolean, default: false
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id), null: false

      timestamps()
    end

    create index(:devices, [:user_id])
  end
end
