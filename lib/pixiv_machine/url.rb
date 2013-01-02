module PixivMachine::URL
  ROOT = "http://www.pixiv.net"

  INDEX_PAGE = "index.php"
  INDEX = "#{ROOT}/#{INDEX_PAGE}"

  LOGIN_PAGE = "login.php"
  LOGIN = "#{ROOT}/#{LOGIN_PAGE}"

  BOOKMARK_PAGE = "bookmark.php"
  BOOKMARK = "#{ROOT}/#{BOOKMARK_PAGE}"
  USER_BOOKMARK = "#{BOOKMARK}?type=user"

  USER_ILLUST_PAGE = "member_illust.php"
  USER_ILLUST = "#{ROOT}/#{USER_ILLUST_PAGE}"

  def user_bookmark_path(rest, page_index)
    "#{USER_BOOKMARK}&rest=#{rest}&p=#{page_index}"
  end

  def user_illust_path(id, page_index)
    "#{USER_ILLUST}?id=#{id}&p=#{page_index}"
  end
end
