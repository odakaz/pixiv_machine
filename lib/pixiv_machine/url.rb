module PixivMachine::URL
  ROOT = "http://www.pixiv.net"

  INDEX = "index.php"
  INDEX_PATH = "#{ROOT}/#{INDEX}"

  LOGIN = "login.php"
  LOGIN_PATH = "#{ROOT}/#{LOGIN}"

  MYPAGE = "mypage.php"
  MYPAGE_PATH = "#{ROOT}/#{MYPAGE}"

  BOOKMARK = "bookmark.php"
  BOOKMARK_PATH = "#{ROOT}/#{BOOKMARK}"
  USER_BOOKMARK_PATH = "#{BOOKMARK_PATH}?type=user"

  USER_ILLUST = "member_illust.php"
  USER_ILLUST_PATH = "#{ROOT}/#{USER_ILLUST}"

  def user_bookmark_path(rest, page_number)
    "#{USER_BOOKMARK_PATH}&rest=#{rest}&p=#{page_number}"
  end

  def user_illust_path(user_id, page_number)
    "#{USER_ILLUST_PATH}?id=#{user_id}&p=#{page_number}"
  end

  def illust_overview_path(illust_id)
    content_path('medium', illust_id)
  end

  def illust_detail_path(illust_id)
    content_path('big', illust_id)
  end

  def manga_detail_path(manga_id)
    content_path('manga', manga_id)
  end

  private
  def content_path(mode, id)
    "#{USER_ILLUST_PATH}?mode=#{mode}&illust_id=#{id}"
  end
end
