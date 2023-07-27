defmodule Truckcheck.Vehicles.Vehicle do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "vehicles" do
    field :driver, :string
    field :license_plate, :string
    field :mileage, :string
    field :chassis_number, :string
    field :error_description, :string
    field :vehicle_id, :binary_id
    field :customer_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(vehicle, attrs) do
    vehicle
    |> cast(attrs, [:license_plate, :mileage, :chassis_number, :driver, :error_description])
    |> validate_required([:license_plate, :mileage, :chassis_number, :driver, :error_description])
  end
end
