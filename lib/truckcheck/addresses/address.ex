defmodule Truckcheck.Addresses.Address do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "addresses" do
    field :street, :string
    field :house_number, :string
    field :zip_code, :string
    field :city, :string
    field :user_id, :binary_id
    field :customer_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:street, :house_number, :zip_code, :city])
    |> validate_required([:street, :house_number, :zip_code, :city])
  end
end
