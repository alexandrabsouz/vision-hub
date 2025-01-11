defmodule VisionHub.Accounts.Device do
  @moduledoc """
  The `VisionHub.Device` module defines the schema and changesets for the Device entity in the VisionHub application.

  This module uses Ecto to interact with the database and provides functions to validate and manipulate device data.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias VisionHub.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:brand, :user_id]
  @derive {Jason.Encoder, only: [:id, :brand, :is_active, :user_id, :name]}

  schema "devices" do
    field :brand, :string
    field :is_active, :boolean
    field :name, :string

    belongs_to :user, User

    timestamps()
  end

  @doc """
  Builds a changeset for creating a device.
  """
  def build(changeset), do: apply_action(changeset, :create)

  @doc """
  Creates a changeset based on the `struct` and `params`.

  ## Examples

      iex> changeset(%VisionHub.Device{}, %{brand: "BrandName", is_active: true, user_id: "some-user-id"})
      %Ecto.Changeset{...}

  """
  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params ++ [:is_active])
    |> validate_required(@required_params)
  end
end
