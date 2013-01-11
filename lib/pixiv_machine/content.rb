class PixivMachine::Content
  include PixivMachine::URL
  attr_reader :id, :thumbnail_uri

  def initialize(id, thumbnail_uri)
    @id = id
    @thumbnail_uri = thumbnail_uri
  end

  def overview_uri
    illust_overview_path(id)
  end
end
