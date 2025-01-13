defmodule VisionHub.Accounts.User do
  @moduledoc """
  The `VisionHub.User` module defines the schema and changesets for the User entity in the VisionHub application.

  This module uses Ecto to interact with the database and provides functions to validate and manipulate user data.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias VisionHub.Accounts.Device

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:email, :name]
  @derive {Jason.Encoder, only: [:id, :name, :email, :devices, :deactivated_at]}

  schema "users" do
    field :email, :string
    field :name, :string
    field :deactivated_at, :utc_datetime, default: nil

    has_many :devices, Device

    timestamps()
  end

  @doc """
  Builds a changeset for creating a user.
  """
  def build(changeset), do: apply_action(changeset, :create)

  @doc """
  Creates a changeset based on the `struct` and `params`.

  ## Examples

      iex> changeset(%VisionHub.User{}, %{email: "test@example.com", name: "Test User"})
      %Ecto.Changeset{...}

  """
  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params ++ [:deactivated_at])
    |> validate_required(@required_params)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
