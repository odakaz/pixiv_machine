# -*- coding: utf-8 -*-
require 'rubygems'
require 'mechanize'
require 'logger'

class PixivMachine
  attr_reader :my_page

  def initialize(id, password)
    @id = id
    @password = password
    @agent = Mechanize.new

    @my_page = MyPage.new(id, password, @agent)
  end
end

class PixivMachine::PixivError < StandardError
end

class PixivMachine::LoginError < PixivMachine::PixivError
end

require File.expand_path(File.dirname(__FILE__) + '/pixiv_machine/url')
require File.expand_path(File.dirname(__FILE__) + '/pixiv_machine/page')
require File.expand_path(File.dirname(__FILE__) + '/pixiv_machine/pageable_page')
require File.expand_path(File.dirname(__FILE__) + '/pixiv_machine/my_page')
require File.expand_path(File.dirname(__FILE__) + '/pixiv_machine/user_page')
require File.expand_path(File.dirname(__FILE__) + '/pixiv_machine/illust_page')
