defmodule Truckcheck.CustomersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Truckcheck.Customers` context.
  """

  @doc """
  Generate a customer.
  """
  def customer_fixture(attrs \\ %{}) do
    {:ok, customer} =
      attrs
      |> Enum.into(%{
        first_name: "some first_name",
        last_name: "some last_name",
        company_name: "some company_name",
        phone_number: "some phone_number"
      })
      |> Truckcheck.Customers.create_customer()

    customer
  end
end
