defmodule UploadWeb.UserController do
  use UploadWeb, :controller

  alias Upload.Account
  alias Upload.User

  def index(conn, _params) do
    users = Account.list_users(%User{})
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    id = String.to_integer(id)
    user = Account.get_user(id)
    render(conn, "show.html", user: user)
  end
end
