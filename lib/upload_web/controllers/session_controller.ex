defmodule UploadWeb.SessionController do
  use UploadWeb, :controller
  alias UploadWeb.Auth

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => pass}}) do
    case Auth.login_by_email_and_password(conn, email, pass) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome")
        |> redirect(to: "/")

      {:error, _, conn} ->
        conn
        |> put_flash(:error, "invalid username/password")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> Auth.logout()
    |> redirect(to: "/")
  end
end
