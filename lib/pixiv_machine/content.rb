class PixivMachine::Content
  include PixivMachine::URL
  attr_reader :id, :title, :thumbnail_uri

  def initialize(id, title, thumbnail_uri)
    @id = id
    @title = title
    @thumbnail_uri = thumbnail_uri
  end

  def overview_uri
    illust_overview_path(id)
  end
end
