defmodule Upload.Repo.Migrations.CreateVideos do
  use Ecto.Migration

  def change do
    create table(:videos) do
      add :url, :string
      add :title, :string
      add :description, :string
      add :usertest_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
  end
end
