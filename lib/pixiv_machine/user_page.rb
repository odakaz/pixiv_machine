class PixivMachine::UserPage < PixivMachine::PageablePage
  attr_reader :id

  def initialize(login_id, password, id, agent)
    super(login_id, password, agent)
    @id = id
  end

  def illust_page(page_number = 1)
    get(user_illust_path(id, page_number))
    self
  end

  def illusts(page_number = 1)
    get_illusts(illust_page(page_number).page)
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
