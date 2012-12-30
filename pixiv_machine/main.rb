require 'mechanize'

class PixivMachine::Main < PixivMachine::Base
  attr_reader :id, :password
  def initialize(id, password)
    super(Mechanize.new)
    @id = id
    @password = password
  end

  def user_bookmark(rest='show')
    get("#{USER_BOOKMARK}&rest=#{rest}")
    self
  end

  def hidden_user_bookmark
    user_bookmark('hide')
    self
  end

  def members
    get_members(user_bookmark.page)
  end

  def hidden_members
    get_members(hidden_user_bookmark.page)
  end

  private
  def get_members(page)
    members = []
    page.search('div.userdata a').each do |m|
      id = m[:href].match(/id=(\d+)/).to_a[1]
      members << PixivMachine::Member.new(id, agent) if id
    end
    members
  end
end
