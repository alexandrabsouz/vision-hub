defmodule VisionHub.User do
  @moduledoc """
  The `VisionHub.User` module defines the schema and changesets for the User entity in the VisionHub application.

  This module uses Ecto to interact with the database and provides functions to validate and manipulate user data.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias VisionHub.Device

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:email, :name]
  @derive {Jason.Encoder, only: [:id, :name, :email]}

  schema "users" do
    field :email, :string
    field :name, :string
    field :is_active, :boolean, default: true

    has_many :device, Device

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
    |> cast(params, @required_params)
    |> validate_required(@required_params ++ [:is_active])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
