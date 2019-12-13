defmodule UploadWeb.VideoView do
  use UploadWeb, :view

  alias Upload.Repo

  def category_select_option(categories) do
    for category <- categories do
      {category.name, category.id}
    end
  end

  def category_name(video) do
    preloaded_video = Repo.preload(video, :category)
    preloaded_video.category.name
  end
end
