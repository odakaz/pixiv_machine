# -*- coding: utf-8 -*-
require 'rubygems'
require 'mechanize'
require 'logger'

module PixivMachine
  module URLConstants
    ROOT = "http://www.pixiv.net"

    INDEX_PAGE = "index.php"
    INDEX = "#{ROOT}/#{INDEX_PAGE}"

    LOGIN_PAGE = "login.php"

    BOOKMARK_PAGE = "bookmark.php"
    BOOKMARK = "#{ROOT}/#{BOOKMARK_PAGE}"
    USER_BOOKMARK = "#{BOOKMARK}?type=user"
  end
end

class PixivMachine::PixivError < StandardError
end

class PixivMachine::LoginError < PixivMachine::PixivError
end

require File.expand_path('./pixiv_machine/base')
require File.expand_path('./pixiv_machine/main')
require File.expand_path('./pixiv_machine/member')
