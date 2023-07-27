defmodule TruckcheckWeb.AddressLiveTest do
  use TruckcheckWeb.ConnCase

  import Phoenix.LiveViewTest
  import Truckcheck.AddressesFixtures

  @create_attrs %{street: "some street", house_number: "some house_number", zip_code: "some zip_code", city: "some city"}
  @update_attrs %{street: "some updated street", house_number: "some updated house_number", zip_code: "some updated zip_code", city: "some updated city"}
  @invalid_attrs %{street: nil, house_number: nil, zip_code: nil, city: nil}

  defp create_address(_) do
    address = address_fixture()
    %{address: address}
  end

  describe "Index" do
    setup [:create_address]

    test "lists all addresses", %{conn: conn, address: address} do
      {:ok, _index_live, html} = live(conn, ~p"/addresses")

      assert html =~ "Listing Addresses"
      assert html =~ address.street
    end

    test "saves new address", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/addresses")

      assert index_live |> element("a", "New Address") |> render_click() =~
               "New Address"

      assert_patch(index_live, ~p"/addresses/new")

      assert index_live
             |> form("#address-form", address: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#address-form", address: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/addresses")

      html = render(index_live)
      assert html =~ "Address created successfully"
      assert html =~ "some street"
    end

    test "updates address in listing", %{conn: conn, address: address} do
      {:ok, index_live, _html} = live(conn, ~p"/addresses")

      assert index_live |> element("#addresses-#{address.id} a", "Edit") |> render_click() =~
               "Edit Address"

      assert_patch(index_live, ~p"/addresses/#{address}/edit")

      assert index_live
             |> form("#address-form", address: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#address-form", address: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/addresses")

      html = render(index_live)
      assert html =~ "Address updated successfully"
      assert html =~ "some updated street"
    end

    test "deletes address in listing", %{conn: conn, address: address} do
      {:ok, index_live, _html} = live(conn, ~p"/addresses")

      assert index_live |> element("#addresses-#{address.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#addresses-#{address.id}")
    end
  end

  describe "Show" do
    setup [:create_address]

    test "displays address", %{conn: conn, address: address} do
      {:ok, _show_live, html} = live(conn, ~p"/addresses/#{address}")

      assert html =~ "Show Address"
      assert html =~ address.street
    end

    test "updates address within modal", %{conn: conn, address: address} do
      {:ok, show_live, _html} = live(conn, ~p"/addresses/#{address}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Address"

      assert_patch(show_live, ~p"/addresses/#{address}/show/edit")

      assert show_live
             |> form("#address-form", address: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#address-form", address: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/addresses/#{address}")

      html = render(show_live)
      assert html =~ "Address updated successfully"
      assert html =~ "some updated street"
    end
  end
end
