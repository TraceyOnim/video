defmodule UploadWeb.VideoController do
  use UploadWeb, :controller

  alias Upload.Account.Video, as: Accounts
  alias Upload.Account.Category, as: Multimedia
  alias Upload.Category
  alias Upload.Video

  plug :load_categories when action in [:new, :create, :edit, :update]

  def new(conn, _param) do
    changeset = Accounts.change_video(%Video{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"video" => video}) do
    case Accounts.create_video(video) do
      {:ok, _video} ->
        conn
        |> put_flash(:info, "Video created successfully")
        |> redirect(to: "/")

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Something went wrong, Try Again")
        |> render("new.html", changeset: changeset)
    end
  end

  def index(conn, _param) do
    videos = Accounts.list_videos()
    render(conn, "index.html", videos: videos)
  end

  defp load_categories(conn, _opts) do
    assign(conn, :categories, Multimedia.list_all_categories(Category))
  end
end
