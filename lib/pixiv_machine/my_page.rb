# -*- coding: utf-8 -*-
class PixivMachine::MyPage < PixivMachine::PageablePage
  # 公開中のお気に入りユーザーブックマークページ
  def shown_user_bookmark_page(page_number = 1)
    user_bookmark_page('show', page_number)
    self
  end

  # 非公開中のお気に入りユーザーブックマークページ
  def hidden_user_bookmark_page(page_number = 1)
    user_bookmark_page('hide', page_number)
    self
  end

  # 公開中のお気に入りユーザーのリスト
  def shown_users(page_number = 1)
    get_users(shown_user_bookmark_page(page_number).page)
  end

  # 非公開中のお気に入りユーザーのリスト
  def hidden_users(page_number = 1)
    get_users(hidden_user_bookmark_page(page_number).page)
  end

  private
  def user_bookmark_page(rest, page_number = 1)
    get(user_bookmark_path(rest, page_number))
    self
  end

  def get_users(page)
    users = []
    page.search('div.userdata a').each do |u|
      id = u[:href].match(/id=(\d+)/).to_a[1]
      users << PixivMachine::UserPage.new(agent, login_id, password, id) if id
    end

    users
  end
end
