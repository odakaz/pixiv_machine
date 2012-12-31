# -*- coding: utf-8 -*-
require 'logger'
require 'uri'

class PixivMachine::Page
  include PixivMachine::URL
  attr_reader :agent, :page

  def initialize(agent)
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::DEBUG
    @agent = agent
  end

  private
  def login(page = nil)
    @logger.debug("login")
    login_page = page || agent.get(INDEX)

    login_form = login_page.form_with(:class => 'login-form')
    login_form['pixiv_id'] = @id
    login_form['pass'] = @password

    @page = login_form.submit

    raise PixivMachine::LoginError if @page.uri.request_uri =~ /#{LOGIN_PAGE}/
    self
  end

  def get(uri, parameters = [], referer = nil, headers = {}, &block)
    @logger.debug("get [#{uri}] -> [#{full_path(uri)}]")
    sleep 1
    @page = agent.get(full_path(uri), parameters, referer, headers)

    # index.phpに戻ってきちゃったらログインしなおす。
    # ログインしなおすと、元々開きたかったページに勝手に行く。
    login(@page) if @page.uri.request_uri =~ /#{INDEX_PAGE}/

    yield @page if block_given?
    self
  end

  # 現在のページを基準にしたフルパス
  def full_path(uri)
    return URI.parse(uri).to_s unless page

    URI.join(page.uri, uri).to_s
  end
end
