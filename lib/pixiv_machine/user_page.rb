class PixivMachine::UserPage < PixivMachine::PageablePage
  attr_reader :id

  def initialize(id, agent)
    super(agent)
    @id = id
  end

  def illust_page(page_index = 0)
    get(user_illust_path(id, page_index))
    self
  end

  def illusts(page_index = 0)
    get_illusts(illust_page(page_index).page)
  end

  private
  def get_illusts(page)
    illusts = []
    page.search('div.display_works li a').each do |i|
      id = i[:href].match(/illust_id=(\d+)/).to_a[1]
      illusts << PixivMachine::IllustPage.new(id, agent) if id
    end

    illusts
  end
end
