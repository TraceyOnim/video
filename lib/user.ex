defmodule Upload.User do
  use Ecto.Schema

  schema "users" do
    field :name, :string
    field :age, :integer, default: 0
  end
end
