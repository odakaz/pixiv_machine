# -*- coding: utf-8 -*-
require 'logger'

class PixivMachine::Base
  include PixivMachine::URLConstants
  attr_reader :agent

  def initialize(agent)
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::DEBUG
    @agent = agent
  end

  def page
    return @agent.page
  end

  private
  def login(page = nil)
    @logger.debug("login")
    login_page = page || agent.get(INDEX)

    login_form = login_page.form_with(:class => 'login-form')
    login_form['pixiv_id'] = @id
    login_form['pass'] = @password

    raise PixivMachine::LoginError if login_form.submit.uri.request_uri =~ /LOGIN_PAGE/
    self
  end

  def get(uri, parameters = [], referer = nil, headers = {}, &block)
    @logger.debug("get")
    sleep 1
    res_page = agent.get(uri, parameters, referer, headers)

    # index.phpに戻ってきちゃったらログインしなおす。
    login(res_page) if res_page.uri.request_uri =~ /#{INDEX_PAGE}/

    yield page if block_given?
    self
  end
end

