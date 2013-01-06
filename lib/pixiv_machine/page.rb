# -*- coding: utf-8 -*-
require 'logger'
require 'uri'

class PixivMachine::Page
  include PixivMachine::URL
  attr_reader :login_id, :password, :agent, :page

  def initialize(login_id, password, agent)
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::DEBUG

    @login_id = login_id
    @password = password
    @agent = agent
  end

  def login(page = nil)
    login_page = page || agent.get(INDEX_PATH)
    login_form = login_page.form_with(:class => 'login-form')
    login_form['pixiv_id'] = @login_id
    login_form['pass'] = @password

    @page = login_form.submit

    raise PixivMachine::LoginError if @page.uri.request_uri =~ /#{LOGIN}/
    self
  end

  private
  def get(uri, parameters = [], referer = nil, headers = {}, &block)
    @logger.debug("get [#{uri}] -> [#{full_path(uri)}]")
    sleep 0.5
    @page = agent.get(full_path(uri), parameters, referer, headers)

    # index.phpに戻ってきちゃったらログインしなおす。
    # ログインしなおすと、元々開きたかったページに勝手に行く。
    login(@page) if @page.uri.request_uri =~ /#{INDEX}/

    yield @page if block_given?
    self
  end

  # 現在のページを基準にしたフルパス
  def full_path(uri)
    return URI.parse(uri).to_s unless page

    URI.join(page.uri, uri).to_s
  end
end
