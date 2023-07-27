defmodule Truckcheck.VehiclesTest do
  use Truckcheck.DataCase

  alias Truckcheck.Vehicles

  describe "vehicles" do
    alias Truckcheck.Vehicles.Vehicle

    import Truckcheck.VehiclesFixtures

    @invalid_attrs %{driver: nil, license_plate: nil, mileage: nil, chassis_number: nil, error_description: nil}

    test "list_vehicles/0 returns all vehicles" do
      vehicle = vehicle_fixture()
      assert Vehicles.list_vehicles() == [vehicle]
    end

    test "get_vehicle!/1 returns the vehicle with given id" do
      vehicle = vehicle_fixture()
      assert Vehicles.get_vehicle!(vehicle.id) == vehicle
    end

    test "create_vehicle/1 with valid data creates a vehicle" do
      valid_attrs = %{driver: "some driver", license_plate: "some license_plate", mileage: "some mileage", chassis_number: "some chassis_number", error_description: "some error_description"}

      assert {:ok, %Vehicle{} = vehicle} = Vehicles.create_vehicle(valid_attrs)
      assert vehicle.driver == "some driver"
      assert vehicle.license_plate == "some license_plate"
      assert vehicle.mileage == "some mileage"
      assert vehicle.chassis_number == "some chassis_number"
      assert vehicle.error_description == "some error_description"
    end

    test "create_vehicle/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Vehicles.create_vehicle(@invalid_attrs)
    end

    test "update_vehicle/2 with valid data updates the vehicle" do
      vehicle = vehicle_fixture()
      update_attrs = %{driver: "some updated driver", license_plate: "some updated license_plate", mileage: "some updated mileage", chassis_number: "some updated chassis_number", error_description: "some updated error_description"}

      assert {:ok, %Vehicle{} = vehicle} = Vehicles.update_vehicle(vehicle, update_attrs)
      assert vehicle.driver == "some updated driver"
      assert vehicle.license_plate == "some updated license_plate"
      assert vehicle.mileage == "some updated mileage"
      assert vehicle.chassis_number == "some updated chassis_number"
      assert vehicle.error_description == "some updated error_description"
    end

    test "update_vehicle/2 with invalid data returns error changeset" do
      vehicle = vehicle_fixture()
      assert {:error, %Ecto.Changeset{}} = Vehicles.update_vehicle(vehicle, @invalid_attrs)
      assert vehicle == Vehicles.get_vehicle!(vehicle.id)
    end

    test "delete_vehicle/1 deletes the vehicle" do
      vehicle = vehicle_fixture()
      assert {:ok, %Vehicle{}} = Vehicles.delete_vehicle(vehicle)
      assert_raise Ecto.NoResultsError, fn -> Vehicles.get_vehicle!(vehicle.id) end
    end

    test "change_vehicle/1 returns a vehicle changeset" do
      vehicle = vehicle_fixture()
      assert %Ecto.Changeset{} = Vehicles.change_vehicle(vehicle)
    end
  end
end
