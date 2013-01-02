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

  def user_bookmark_path(rest, page_index)
    "#{USER_BOOKMARK_PATH}&rest=#{rest}&p=#{page_index}"
  end

  def user_illust_path(id, page_index)
    "#{USER_ILLUST_PATH}?id=#{id}&p=#{page_index}"
  end
end
