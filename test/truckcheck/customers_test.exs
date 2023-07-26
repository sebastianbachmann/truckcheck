defmodule Truckcheck.CustomersTest do
  use Truckcheck.DataCase

  alias Truckcheck.Customers

  describe "customers" do
    alias Truckcheck.Customers.Customer

    import Truckcheck.CustomersFixtures

    @invalid_attrs %{first_name: nil, last_name: nil, company_name: nil, phone_number: nil}

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Customers.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Customers.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      valid_attrs = %{first_name: "some first_name", last_name: "some last_name", company_name: "some company_name", phone_number: "some phone_number"}

      assert {:ok, %Customer{} = customer} = Customers.create_customer(valid_attrs)
      assert customer.first_name == "some first_name"
      assert customer.last_name == "some last_name"
      assert customer.company_name == "some company_name"
      assert customer.phone_number == "some phone_number"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Customers.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      update_attrs = %{first_name: "some updated first_name", last_name: "some updated last_name", company_name: "some updated company_name", phone_number: "some updated phone_number"}

      assert {:ok, %Customer{} = customer} = Customers.update_customer(customer, update_attrs)
      assert customer.first_name == "some updated first_name"
      assert customer.last_name == "some updated last_name"
      assert customer.company_name == "some updated company_name"
      assert customer.phone_number == "some updated phone_number"
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Customers.update_customer(customer, @invalid_attrs)
      assert customer == Customers.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Customers.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> Customers.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Customers.change_customer(customer)
    end
  end
end
