defmodule UploadWeb.UsertestController do
  use UploadWeb, :controller

  alias Upload.Accounttest
  alias Upload.Usertest

  plug :authenticate when action in [:index]

  def new(conn, _param) do
    changeset = Accounttest.change_user(%Usertest{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"usertest" => usertest}) do
    case Accounttest.register_user(usertest) do
      {:ok, user} ->
        conn
        |> UploadWeb.Auth.login(user)
        |> put_flash(:info, "#{user.name} created successfully")
        |> redirect(to: "/")

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def index(conn, _param) do
    userss = Accounttest.list_users()
    render(conn, "index.html", userss: userss)
  end
end
