defmodule Upload.Account.Category do
  import Ecto.Query
  alias Upload.Category
  alias Upload.Repo

  @doc """
  Fetches existing data from database or creates new ones otherwise
  """
  @spec create_category(String.t()) :: %Category{}
  def create_category(name) do
    Repo.get_by(Category, name: name) || Repo.insert!(%Category{name: name})
  end

  @doc """
  Fetches all categories name from the database.
  Returns a list of %Category{}.
  """
  def list_all_categories(query) do
    query
    |> category_query()
    |> Repo.all()
    |> IO.inspect(label: "list")
  end

  defp category_query(query) do
    from c in query,
      order_by: c.name
  end
end
