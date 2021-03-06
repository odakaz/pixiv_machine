# -*- coding: utf-8 -*-
require 'rubygems'
require 'mechanize'
require 'logger'

class PixivMachine
  attr_reader :my_page

  @@logger = Logger.new(STDOUT)
  @@logger.level = Logger::WARN

  def initialize(login_id, password)
    @agent = Mechanize.new

    @my_page = MyPage.new(@agent, login_id, password)
  end

  def self.log_level=(level)
    @@logger.level = level
  end

  def self.logger
    @@logger
  end
end

class PixivMachine::PixivError < StandardError
end

class PixivMachine::LoginError < PixivMachine::PixivError
end

require_relative 'pixiv_machine/url'

require_relative 'pixiv_machine/page'
require_relative 'pixiv_machine/my_page'
require_relative 'pixiv_machine/user_page'

require_relative 'pixiv_machine/user_bookmark_page'
require_relative 'pixiv_machine/illusts_page'

require_relative 'pixiv_machine/content'
