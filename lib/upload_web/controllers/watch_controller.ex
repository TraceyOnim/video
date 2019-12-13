defmodule UploadWeb.WatchController do
  use UploadWeb, :controller

  alias Upload.Account.Video, as: Account

  def show(conn, %{"id" => id}) do
    video = Account.get_video(id)
    render(conn, "show.html", video: video)
  end
end
