defmodule Upload.Account.Video do
  @moduledoc """
      This is video context 
  """
  alias Upload.Repo
  alias Upload.Video

  @doc """
  Returns a changeset
  """
  @spec change_video(struct(), map()) :: %Ecto.Changeset{}
  def change_video(%Video{} = video, attrs \\ %{}) do
    video
    |> Video.changeset(attrs)
  end

  @doc """
  create_video/1 inserts video to the database.
  Returns {:ok, %Video{}} if inserted successfully otherwise
  {:error, %Ecto.Changeset{}} incase of violation of data integrity
  """
  @spec create_video(map()) :: {:ok, %Video{}} | {:error, %Ecto.Changeset{}}
  def create_video(attrs) do
    %Video{}
    |> change_video(attrs)
    |> Repo.insert()
  end

  @doc """
  gets all videos from the database
  """
  @spec list_videos() :: [%Video{}, ...]
  def list_videos do
    Video
    |> Repo.all()
  end

  @doc """
  Fetches a video from database whose id given matches its primary key
  """
  @spec get_video(integer()) :: %Video{}
  def get_video(id) do
    Video
    |> Repo.get(id)
  end
end
