defmodule Truckcheck.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :first_name, :string
      add :last_name, :string
      add :company_name, :string
      add :phone_number, :string
      add :customer_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:customers, [:customer_id])
  end
end
