defmodule Upload.Category do
  use Ecto.Schema

  schema "categories" do
    field :name, :string
  end
end
