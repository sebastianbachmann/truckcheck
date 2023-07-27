defmodule Truckcheck.AddressesTest do
  use Truckcheck.DataCase

  alias Truckcheck.Addresses

  describe "addresses" do
    alias Truckcheck.Addresses.Address

    import Truckcheck.AddressesFixtures

    @invalid_attrs %{street: nil, house_number: nil, zip_code: nil, city: nil}

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Addresses.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Addresses.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      valid_attrs = %{street: "some street", house_number: "some house_number", zip_code: "some zip_code", city: "some city"}

      assert {:ok, %Address{} = address} = Addresses.create_address(valid_attrs)
      assert address.street == "some street"
      assert address.house_number == "some house_number"
      assert address.zip_code == "some zip_code"
      assert address.city == "some city"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Addresses.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      update_attrs = %{street: "some updated street", house_number: "some updated house_number", zip_code: "some updated zip_code", city: "some updated city"}

      assert {:ok, %Address{} = address} = Addresses.update_address(address, update_attrs)
      assert address.street == "some updated street"
      assert address.house_number == "some updated house_number"
      assert address.zip_code == "some updated zip_code"
      assert address.city == "some updated city"
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Addresses.update_address(address, @invalid_attrs)
      assert address == Addresses.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Addresses.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Addresses.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Addresses.change_address(address)
    end
  end
end
