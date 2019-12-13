defmodule UploadWeb.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias Upload.Accounttest

  alias UploadWeb.Router.Helpers, as: Routes

  def init(opts), do: opts |> IO.inspect(label: "check options")

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Accounttest.get_user(user_id)

    assign(conn, :current_user, user)
    |> IO.inspect()
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    conn
    |> configure_session(drop: true)
  end

  def login_by_email_and_password(conn, email, pass) do
    case Upload.Accounttest.authenticate_by_email_and_password(email, pass) do
      {:ok, user} -> {:ok, login(conn, user)}
      {:error, :unauthorized} -> {:error, :unauthorized, conn}
      {:error, :not_found} -> {:error, :not_found, conn}
    end
  end

  def authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: "/")
      |> halt()
    end
  end
end
