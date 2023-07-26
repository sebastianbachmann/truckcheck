defmodule Truckcheck.VehiclesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Truckcheck.Vehicles` context.
  """

  @doc """
  Generate a vehicle.
  """
  def vehicle_fixture(attrs \\ %{}) do
    {:ok, vehicle} =
      attrs
      |> Enum.into(%{
        driver: "some driver",
        license_plate: "some license_plate",
        mileage: "some mileage",
        chassis_number: "some chassis_number",
        error_description: "some error_description"
      })
      |> Truckcheck.Vehicles.create_vehicle()

    vehicle
  end
end
