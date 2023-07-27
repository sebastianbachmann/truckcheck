defmodule Truckcheck.Customers.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "customers" do
    field :first_name, :string
    field :last_name, :string
    field :company_name, :string
    field :phone_number, :string
    field :customer_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:first_name, :last_name, :company_name, :phone_number])
    |> validate_required([:first_name, :last_name, :company_name, :phone_number])
  end
end
