require_relative 'pageable_page'
require_relative 'url'

class PixivMachine::UserBookmarkPage < PixivMachine::PageablePage
  include PixivMachine::URL
  attr_reader :rest

  def initialize(agent, login_id, password, rest, page_number = 1)
    super(agent, login_id, password, page_number)
    @rest = rest
  end

  def users(page_number = current_page_number)
    get_users(nth_page(page_number).page)
  end

  private
  def get_users(page)
    users = []
    page.search('div.userdata a').each do |u|
      id = u[:href].match(/id=(\d+)/).to_a[1]
      users << PixivMachine::UserPage.new(agent, login_id, password, id) if id
    end

    users
  end

  def page_to_uri(page_number)
    user_bookmark_path(rest, page_number)
  end

  def check_has_next
    next_link = page.search("div.pages ol li a.button[rel='next']")
    !next_link.empty?
  end

  def check_has_prev
    prev_link = page.search("div.pages ol li a.button[rel='prev']")
    !prev_link.empty?
  end
end
