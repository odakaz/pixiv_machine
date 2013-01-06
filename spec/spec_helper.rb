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
  WebMock.stub_request(:post, LOGIN_PATH).
    to_return(:status => 302, 
              :headers => {'Location' => MYPAGE_PATH})

  # マイページ
  WebMock.stub_request(:get, MYPAGE_PATH).
    to_return(:status => 200,
              :headers => {'Content-Type' => 'text/html'},
              :body => File.new("#{FIXTURE_ROOT}/mypage"))

  # 公開中お気に入りユーザーブックマークページ　１ページ目
  WebMock.stub_request(:get, BOOKMARK_PATH).
    with(:query => {:type => 'user', :p => '1', :rest => 'show'}).
    to_return(:status => 200,
              :headers => {'Content-Type' => 'text/html'},
              :body => File.new("#{FIXTURE_ROOT}/shown_user_bookmark_page_1"))

  # 公開中お気に入りユーザーブックマークページ　２ページ目
  WebMock.stub_request(:get, BOOKMARK_PATH).
    with(:query => {:type => 'user', :p => '2', :rest => 'show'}).
    to_return(:status => 200,
              :headers => {'Content-Type' => 'text/html'},
              :body => File.new("#{FIXTURE_ROOT}/shown_user_bookmark_page_2"))

  # 非公開中お気に入りユーザーブックマークページ　１ページ目
  WebMock.stub_request(:get, BOOKMARK_PATH).
    with(:query => {:type => 'user', :p => '1', :rest => 'hide'}).
    to_return(:status => 200,
              :headers => {'Content-Type' => 'text/html'},
              :body => File.new("#{FIXTURE_ROOT}/hidden_user_bookmark_page_1"))

  # 非公開中お気に入りユーザーブックマークページ　２ページ目
  WebMock.stub_request(:get, BOOKMARK_PATH).
    with(:query => {:type => 'user', :p => '2', :rest => 'hide'}).
    to_return(:status => 200,
              :headers => {'Content-Type' => 'text/html'},
              :body => File.new("#{FIXTURE_ROOT}/hidden_user_bookmark_page_2"))

  # 作品一覧ページ　１ページ目
  WebMock.stub_request(:get, USER_ILLUST_PATH).
    with(:query => {:id => '999', :p => 1}).
    to_return(:status => 200,
              :headers => {'Content-Type' => 'text/html'},
              :body => File.new("#{FIXTURE_ROOT}/user_illust_page_1"))

  # 作品一覧ページ　２ページ目
  WebMock.stub_request(:get, USER_ILLUST_PATH).
    with(:query => {:id => '999', :p => 2}).
    to_return(:status => 200,
              :headers => {'Content-Type' => 'text/html'},
              :body => File.new("#{FIXTURE_ROOT}/user_illust_page_2"))

  # イラストページ
  WebMock.stub_request(:get, USER_ILLUST_PATH).
    with(:query => {:mode => 'medium', :illust_id => '10000'}).
    to_return(:status => 200,
              :headers => {'Content-Type' => 'text/html'},
              :body => File.new("#{FIXTURE_ROOT}/illust_overview"))
  
  # マンガページ
  WebMock.stub_request(:get, USER_ILLUST_PATH).
    with(:query => {:mode => 'medium', :illust_id => '20000'}).
    to_return(:status => 200,
              :headers => {'Content-Type' => 'text/html'},
              :body => File.new("#{FIXTURE_ROOT}/manga_overview"))

  # 存在しないイラストやマンガのページ
  WebMock.stub_request(:get, USER_ILLUST_PATH).
    with(:query => {:mode => 'medium', :illust_id => '30000'}).
    to_return(:status => 200,
              :headers => {'Content-Type' => 'text/html'},
              :body => File.new("#{FIXTURE_ROOT}/blank"))

  # イラストの詳細ページ
  WebMock.stub_request(:get, USER_ILLUST_PATH).
    with(:query => {:mode => 'big', :illust_id => '10000'}).
    to_return(:status => 200,
              :headers => {'Content-Type' => 'text/html'},
              :body => File.new("#{FIXTURE_ROOT}/illust_detail"))

  # マンガの詳細ページ
  WebMock.stub_request(:get, USER_ILLUST_PATH).
    with(:query => {:mode => 'manga', :illust_id => '20000'}).
    to_return(:status => 200,
              :headers => {'Content-Type' => 'text/html'},
              :body => File.new("#{FIXTURE_ROOT}/manga_detail"))

  # 存在しないイラストの詳細ページ
  WebMock.stub_request(:get, USER_ILLUST_PATH).
    with(:query => {:mode => 'big', :illust_id => '30000'}).
    to_return(:status => 200,
              :headers => {'Content-Type' => 'text/html'},
              :body => File.new("#{FIXTURE_ROOT}/blank"))
  
  # 存在しないマンガの詳細ページ
  WebMock.stub_request(:get, USER_ILLUST_PATH).
    with(:query => {:mode => 'manga', :illust_id => '30000'}).
    to_return(:status => 200,
              :headers => {'Content-Type' => 'text/html'},
              :body => File.new("#{FIXTURE_ROOT}/blank"))
  
end
