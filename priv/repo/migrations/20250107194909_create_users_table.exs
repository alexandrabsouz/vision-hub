defmodule VisionHub.Repo.Migrations.CreateUsersTable do
  @moduledoc """
  This migration creates the users table with email, name, and is_active fields.
  """
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string, null: false, size: 50
      add :name, :string, null: false, size: 50

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
