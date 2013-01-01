# -*- coding: utf-8 -*-
class PixivMachine::MyPage < PixivMachine::PageablePage
  attr_reader :id, :password

  def initialize(id, password, agent)
    super(agent)
    @id = id
    @password = password
  end

  def user_bookmark_page(rest, page_index = 0)
    get(user_bookmark_path(rest, page_index))
    self
  end

  # 公開中のお気に入りユーザーブックマークページ
  def shown_user_bookmark_page(page_index = 0)
    user_bookmark_page('show', page_index)
    self
  end

  # 非公開中のお気に入りユーザーブックマークページ
  def hidden_user_bookmark_page(page_index = 0)
    user_bookmark_page('hide', page_index)
    self
  end

  # 公開中のお気に入りユーザーのリスト
  def shown_users(page_index = 0)
    get_users(shown_user_bookmark_page(page_index).page)
  end

  # 非公開中のお気に入りユーザーのリスト
  def hidden_users(page_index = 0)
    get_users(hidden_user_bookmark_page(page_index).page)
  end

  private
  def get_users(page)
    users = []
    page.search('div.userdata a').each do |u|
      id = u[:href].match(/id=(\d+)/).to_a[1]
      users << PixivMachine::UserPage.new(id, agent) if id
    end

    users
  end
end