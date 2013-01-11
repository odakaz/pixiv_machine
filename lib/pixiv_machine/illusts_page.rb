require_relative 'content'

class PixivMachine::IllustsPage < PixivMachine::PageablePage
  include PixivMachine::URL

  attr_reader :user_id

  def initialize(agent, login_id, password, user_id, page_number = 1)
    super(agent, login_id, password)
    @user_id = user_id
    @current_page_number = page_number
  end

  def illusts(page_number = current_page_number)
    get_illusts(get(user_illust_path(user_id, page_number)).page)
  end

  private
  def get_illusts(page)
    illusts = []

    page.search('div.display_works ul li a').each do |i|
      id = i[:href].match(/illust_id=(\d+)/).to_a[1]
      thumbnail_img = i.search('img')
      illusts << PixivMachine::Content.new(id, thumbnail_img.first[:src]) if id && thumbnail_img && !thumbnail_img.empty?
    end

    illusts
  end
end