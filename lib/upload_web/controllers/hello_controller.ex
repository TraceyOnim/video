defmodule UploadWeb.HelloController do
  use UploadWeb, :controller

  def world(conn, %{"name" => name}) do
    IO.inspect(name)
    render(conn, "new.html", name: name)
  end
end
