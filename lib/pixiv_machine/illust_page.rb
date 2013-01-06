require_relative 'detail_page_factory'

class PixivMachine::IllustPage < PixivMachine::Page
  attr_reader :id

  def initialize(login_id, password, id, agent)
    super(login_id, password, agent)
    @id = id
  end

  def overview
    get(illust_overview_path(id))
    self
  end

  def detail
    overview_page = overview.page
    content_link = overview_page.search('div.works_display a').first

    return PixivMachine::DetailPageFactory.detail_page_instance(login_id, password, content_link[:href], agent) if content_link

    nil
  end
end
