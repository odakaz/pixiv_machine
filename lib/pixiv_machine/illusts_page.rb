require_relative 'content'
require_relative 'pageable_page'

class PixivMachine::IllustsPage < PixivMachine::PageablePage
  include PixivMachine::URL

  attr_reader :user_id

  def initialize(agent, login_id, password, user_id, page_number = 1)
    super(agent, login_id, password, page_number)
    @user_id = user_id
  end

  def has_next?
    current
    next_link = page.search("div.pages ol li a.button[rel='next']")
    !next_link.empty?
  end

  def has_prev?
    current
    prev_link = page.search("div.pages ol li a.button[rel='prev']")
    !prev_link.empty?
  end

  def illusts(page_number = current_page_number)
    get_illusts(nth_page(page_number).page)
  end

  private
  def get_illusts(page)
    illusts = []

    page.search('div.display_works ul li a').each do |i|
      id = i[:href].match(/illust_id=(\d+)/).to_a[1]
      thumbnail_img = i.search('img')
      if id && thumbnail_img && !thumbnail_img.empty?
        illusts << PixivMachine::Content.new(id, i.text, thumbnail_img.first[:src]) 
      end
    end

    illusts
  end

  def page_to_uri(page_number)
    user_illust_path(user_id, page_number)
  end
end
