defmodule TruckcheckWeb.VehicleLiveTest do
  use TruckcheckWeb.ConnCase

  import Phoenix.LiveViewTest
  import Truckcheck.VehiclesFixtures

  @create_attrs %{driver: "some driver", license_plate: "some license_plate", mileage: "some mileage", chassis_number: "some chassis_number", error_description: "some error_description"}
  @update_attrs %{driver: "some updated driver", license_plate: "some updated license_plate", mileage: "some updated mileage", chassis_number: "some updated chassis_number", error_description: "some updated error_description"}
  @invalid_attrs %{driver: nil, license_plate: nil, mileage: nil, chassis_number: nil, error_description: nil}

  defp create_vehicle(_) do
    vehicle = vehicle_fixture()
    %{vehicle: vehicle}
  end

  describe "Index" do
    setup [:create_vehicle]

    test "lists all vehicles", %{conn: conn, vehicle: vehicle} do
      {:ok, _index_live, html} = live(conn, ~p"/vehicles")

      assert html =~ "Listing Vehicles"
      assert html =~ vehicle.driver
    end

    test "saves new vehicle", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/vehicles")

      assert index_live |> element("a", "New Vehicle") |> render_click() =~
               "New Vehicle"

      assert_patch(index_live, ~p"/vehicles/new")

      assert index_live
             |> form("#vehicle-form", vehicle: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#vehicle-form", vehicle: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/vehicles")

      html = render(index_live)
      assert html =~ "Vehicle created successfully"
      assert html =~ "some driver"
    end

    test "updates vehicle in listing", %{conn: conn, vehicle: vehicle} do
      {:ok, index_live, _html} = live(conn, ~p"/vehicles")

      assert index_live |> element("#vehicles-#{vehicle.id} a", "Edit") |> render_click() =~
               "Edit Vehicle"

      assert_patch(index_live, ~p"/vehicles/#{vehicle}/edit")

      assert index_live
             |> form("#vehicle-form", vehicle: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#vehicle-form", vehicle: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/vehicles")

      html = render(index_live)
      assert html =~ "Vehicle updated successfully"
      assert html =~ "some updated driver"
    end

    test "deletes vehicle in listing", %{conn: conn, vehicle: vehicle} do
      {:ok, index_live, _html} = live(conn, ~p"/vehicles")

      assert index_live |> element("#vehicles-#{vehicle.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#vehicles-#{vehicle.id}")
    end
  end

  describe "Show" do
    setup [:create_vehicle]

    test "displays vehicle", %{conn: conn, vehicle: vehicle} do
      {:ok, _show_live, html} = live(conn, ~p"/vehicles/#{vehicle}")

      assert html =~ "Show Vehicle"
      assert html =~ vehicle.driver
    end

    test "updates vehicle within modal", %{conn: conn, vehicle: vehicle} do
      {:ok, show_live, _html} = live(conn, ~p"/vehicles/#{vehicle}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Vehicle"

      assert_patch(show_live, ~p"/vehicles/#{vehicle}/show/edit")

      assert show_live
             |> form("#vehicle-form", vehicle: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#vehicle-form", vehicle: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/vehicles/#{vehicle}")

      html = render(show_live)
      assert html =~ "Vehicle updated successfully"
      assert html =~ "some updated driver"
    end
  end
end
