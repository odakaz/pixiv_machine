# -*- coding: utf-8 -*-
require 'webmock/rspec'
require 'pixiv_machine'

FIXTURE_ROOT = File.expand_path(File.dirname(__FILE__) + "/fixtures")

include PixivMachine::URL
def setup_default_fixtures
  WebMock.reset!
  # index
  WebMock.stub_request(:get, INDEX_PATH).
    to_return(:status => 200,
              :headers => {'Content-Type' => 'text/html'},
              :body => File.new("#{FIXTURE_ROOT}/index"))

  # ログイン成功
  WebMock.stub_request(:any, LOGIN_PATH).
    to_return(:status => 302, 
              :headers => {'Location' => MYPAGE_PATH})

  # マイページ
  WebMock.stub_request(:any, MYPAGE_PATH).
    to_return(:status => 200,
              :headers => {'Content-Type' => 'text/html'},
              :body => File.new("#{FIXTURE_ROOT}/mypage"))

  # 公開中お気に入りユーザーブックマークページ　１ページめ
  WebMock.stub_request(:any, BOOKMARK_PATH).
    with(:query => {:type => 'user', :p => '1', :rest => 'show'}).
    to_return(:status => 200,
              :headers => {'Content-Type' => 'text/html'},
              :body => File.new("#{FIXTURE_ROOT}/shown_user_bookmark_page_1"))

  # 公開中お気に入りユーザーブックマークページ　２ページめ
  WebMock.stub_request(:any, BOOKMARK_PATH).
    with(:query => {:type => 'user', :p => '2', :rest => 'show'}).
    to_return(:status => 200,
              :headers => {'Content-Type' => 'text/html'},
              :body => File.new("#{FIXTURE_ROOT}/shown_user_bookmark_page_2"))

  # 非公開中お気に入りユーザーブックマークページ　１ページめ
  WebMock.stub_request(:any, BOOKMARK_PATH).
    with(:query => {:type => 'user', :p => '1', :rest => 'hide'}).
    to_return(:status => 200,
              :headers => {'Content-Type' => 'text/html'},
              :body => File.new("#{FIXTURE_ROOT}/hidden_user_bookmark_page_1"))

  # 非公開中お気に入りユーザーブックマークページ　２ページめ
  WebMock.stub_request(:any, BOOKMARK_PATH).
    with(:query => {:type => 'user', :p => '2', :rest => 'hide'}).
    to_return(:status => 200,
              :headers => {'Content-Type' => 'text/html'},
              :body => File.new("#{FIXTURE_ROOT}/hidden_user_bookmark_page_2"))
end
