defmodule Upload.Video do
  use Ecto.Schema
  alias Upload.Usertest
  alias Upload.Category
  import Ecto.Changeset

  schema "videos" do
    field :url, :string
    field :title, :string
    field :description, :string

    belongs_to :usertest, Usertest
    belongs_to :category, Category
    timestamps()
  end

  def changeset(video, attr \\ %{}) do
    video
    |> cast(attr, [:url, :title, :description])
  end
end
