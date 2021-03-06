# -*- coding: utf-8 -*-
require 'uri'

class PixivMachine::Page
  include PixivMachine::URL
  attr_reader :login_id, :password, :agent, :page

  def initialize(agent, login_id, password)
    @agent = agent
    @login_id = login_id
    @password = password
  end

  def login(page = nil)
    login_page = page || agent.get(INDEX_PATH)
    login_form = login_page.form_with(:action => '/login.php')
    login_form['pixiv_id'] = @login_id
    login_form['pass'] = @password

    @page = login_form.submit

    raise PixivMachine::LoginError if @page.uri.request_uri =~ /#{LOGIN}/
    self
  end

  private
  def get(uri, parameters = [], referer = nil, headers = {}, &block)
    PixivMachine.logger.debug("get [#{full_path(uri)}]")
    sleep 0.5
    @page = agent.get(full_path(uri), parameters, referer, headers)

    # index.phpに戻ってきちゃったらログインしなおす。
    if @page.uri.request_uri =~ /#{INDEX}/
      login(@page) 
      @page = agent.get(full_path(uri), parameters, referer, headers)
    end

    yield @page if block_given?
    self
  end

  # 現在のページを基準にしたフルパス
  def full_path(uri)
    return URI.parse(uri).to_s unless page

    URI.join(page.uri, uri).to_s
  end
end
