defmodule Truckcheck.AddressesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Truckcheck.Addresses` context.
  """

  @doc """
  Generate a address.
  """
  def address_fixture(attrs \\ %{}) do
    {:ok, address} =
      attrs
      |> Enum.into(%{
        street: "some street",
        house_number: "some house_number",
        zip_code: "some zip_code",
        city: "some city"
      })
      |> Truckcheck.Addresses.create_address()

    address
  end
end
