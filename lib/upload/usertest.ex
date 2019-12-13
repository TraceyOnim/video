defmodule Upload.Usertest do
  use Ecto.Schema
  import Ecto.Changeset

  alias Upload.Uploads.Credential

  schema "users" do
    field :name, :string
    field :username, :string
    has_one :credential, Credential
    has_many :video, Upload.Video

    timestamps()
  end

  def changeset(usertest, attrs \\ %{}) do
    usertest
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> validate_length(:username, min: 1, max: 10)
  end

  def registration_changeset(usertest, attrs \\ %{}) do
    usertest
    |> changeset(attrs)
    |> cast_assoc(:credential, with: &Credential.changeset/2, required: true)
  end
end
