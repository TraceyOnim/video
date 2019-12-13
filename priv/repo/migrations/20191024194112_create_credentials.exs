defmodule Upload.Repo.Migrations.CreateCredentials do
  use Ecto.Migration

  def change do
    create table(:credentials) do
      add :email, :string
      add :password_hash, :string
      add :usertest_id, references(:users, on_delete: :delete_all, null: false)

      timestamps()
    end

    create unique_index(:credentials, [:email])
    create index(:credentials, [:usertest_id])
  end
end
