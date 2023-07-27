defmodule TruckcheckWeb.VehicleLive.Index do
  use TruckcheckWeb, :live_view

  alias Truckcheck.Vehicles
  alias Truckcheck.Vehicles.Vehicle

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :vehicles, Vehicles.list_vehicles())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Vehicle")
    |> assign(:vehicle, Vehicles.get_vehicle!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Vehicle")
    |> assign(:vehicle, %Vehicle{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Vehicles")
    |> assign(:vehicle, nil)
  end

  @impl true
  def handle_info({TruckcheckWeb.VehicleLive.FormComponent, {:saved, vehicle}}, socket) do
    {:noreply, stream_insert(socket, :vehicles, vehicle)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    vehicle = Vehicles.get_vehicle!(id)
    {:ok, _} = Vehicles.delete_vehicle(vehicle)

    {:noreply, stream_delete(socket, :vehicles, vehicle)}
  end
end
