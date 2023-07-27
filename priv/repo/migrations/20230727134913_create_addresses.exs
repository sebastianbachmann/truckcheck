defmodule Truckcheck.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :street, :string
      add :house_number, :string
      add :zip_code, :string
      add :city, :string
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :customer_id, references(:customers, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:addresses, [:user_id])
    create index(:addresses, [:customer_id])
  end
end
