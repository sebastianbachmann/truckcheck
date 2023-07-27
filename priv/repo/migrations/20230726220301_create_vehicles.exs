defmodule Truckcheck.Repo.Migrations.CreateVehicles do
  use Ecto.Migration

  def change do
    create table(:vehicles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :license_plate, :string
      add :mileage, :string
      add :chassis_number, :string
      add :driver, :string
      add :error_description, :text
      add :vehicle_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :customer_id, references(:customers, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:vehicles, [:vehicle_id])
    create index(:vehicles, [:customer_id])
  end
end
