defmodule TruckcheckWeb.VehicleLive.FormComponent do
  use TruckcheckWeb, :live_component

  alias Truckcheck.Vehicles

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage vehicle records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="vehicle-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:license_plate]} type="text" label="License plate" />
        <.input field={@form[:mileage]} type="text" label="Mileage" />
        <.input field={@form[:chassis_number]} type="text" label="Chassis number" />
        <.input field={@form[:driver]} type="text" label="Driver" />
        <.input field={@form[:error_description]} type="text" label="Error description" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Vehicle</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{vehicle: vehicle} = assigns, socket) do
    changeset = Vehicles.change_vehicle(vehicle)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"vehicle" => vehicle_params}, socket) do
    changeset =
      socket.assigns.vehicle
      |> Vehicles.change_vehicle(vehicle_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"vehicle" => vehicle_params}, socket) do
    save_vehicle(socket, socket.assigns.action, vehicle_params)
  end

  defp save_vehicle(socket, :edit, vehicle_params) do
    case Vehicles.update_vehicle(socket.assigns.vehicle, vehicle_params) do
      {:ok, vehicle} ->
        notify_parent({:saved, vehicle})

        {:noreply,
         socket
         |> put_flash(:info, "Vehicle updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_vehicle(socket, :new, vehicle_params) do
    case Vehicles.create_vehicle(vehicle_params) do
      {:ok, vehicle} ->
        notify_parent({:saved, vehicle})

        {:noreply,
         socket
         |> put_flash(:info, "Vehicle created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
