# -*- coding: utf-8 -*-
require 'rubygems'
require 'mechanize'
require 'logger'

class PixivMachine
  attr_reader :my_page

  def initialize(login_id, password)
    @agent = Mechanize.new

    @my_page = MyPage.new(login_id, password, @agent)
  end
end

class PixivMachine::PixivError < StandardError
end

class PixivMachine::LoginError < PixivMachine::PixivError
end

require_relative 'pixiv_machine/url'
require_relative 'pixiv_machine/page'
require_relative 'pixiv_machine/pageable_page'
require_relative 'pixiv_machine/my_page'
require_relative 'pixiv_machine/user_page'
require_relative 'pixiv_machine/illust_page'

