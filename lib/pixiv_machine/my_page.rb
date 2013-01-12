# -*- coding: utf-8 -*-
require_relative 'user_bookmark_page'

class PixivMachine::MyPage < PixivMachine::Page
  # 公開中のお気に入りユーザーブックマークページ
  def shown_user_bookmark_page(page_number = 1)
    user_bookmark_page('show', page_number)
  end

  # 非公開中のお気に入りユーザーブックマークページ
  def hidden_user_bookmark_page(page_number = 1)
    user_bookmark_page('hide', page_number)
  end

  def user_bookmark_page(rest, page_number)
    PixivMachine::UserBookmarkPage.new(agent, login_id, password, rest, page_number)
  end
end
