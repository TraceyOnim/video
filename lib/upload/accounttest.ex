defmodule Upload.Accounttest do
  @moduledoc """
   usertest account context
  """

  alias Upload.Repo
  alias Upload.Usertest
  import Ecto.Query

  @doc """
  get_user/1 fetches a single user from the database, where the primary key matches the given id.
  Returns nil if no result was found.
  """
  @spec get_user(integer()) :: Ecto.Schema.t() | nil
  def get_user(id) do
    Repo.get(Usertest, id)
  end

  @doc """
  get_user!/1 fetches a single user from the database, where the primary key matches the given id. Raises 
  Ecto.NoResultsError if no record was found.
  """
  @spec get_user!(integer()) :: Ecto.Schema.t()
  def get_user!(id) do
    Repo.get!(Usertest, id)
  end

  @doc """
  Fetches a single result from the database. Returns nil if no record was found
  """
  @spec get_user_by(map() | Keyword.t()) :: Ecto.Schema.t() | nil
  def get_user_by(params) do
    Repo.get_by(Usertest, params)
  end

  @doc """
  fetches all entries from the database matching the given query
  """
  def list_users do
    Repo.all(Usertest)
  end

  @doc """
  change_user/1 invokes a changeset function from Usertest module.Returns a changeset
  """
  @spec change_user(%Usertest{}) :: %Ecto.Changeset{}
  def change_user(user) do
    user
    |> Usertest.changeset()
  end

  @doc """
  Inserts user to the database
  """
  @spec create_user(map()) :: {:ok, %Usertest{}} | {:error, %Ecto.Changeset{}}
  def create_user(attr \\ %{}) do
    %Usertest{}
    |> Usertest.changeset(attr)
    |> Repo.insert()
  end

  @doc """
  Register user
  """
  @spec register_user(map()) :: {:ok, %Usertest{}} | {:error, %Ecto.Changeset{}}
  def register_user(attrs \\ %{}) do
    %Usertest{}
    |> Usertest.registration_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  get user by email, returns the user whose email matches the given email
  """
   
  def get_user_by_email(email) do
    query = from u in Usertest, join: c in assoc(u, :credential), where: c.email == ^email

    query
    |> Repo.one()
    |> Repo.preload(:credential)
    
  end

  def authenticate_by_email_and_password(email, pass) do

    user = get_user_by_email(email)

    cond do
      user && Comeonin.Pbkdf2.checkpw(pass, user.credential.password_hash) ->
        {:ok, user}

        user -> {:error, :unauthorized}

        true -> 
          Comeonin.Bcrypt.dummy_checkpw()
          {:error, :not_found}
        
    end
        
    
  end

  
end
