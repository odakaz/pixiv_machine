# -*- coding: utf-8 -*-
require 'spec_helper'
include PixivMachine::URL

describe PixivMachine::MyPage do
  before do
    @mech = Mechanize.new
    @page = PixivMachine::MyPage.new("id", "password", @mech)
    setup_default_fixtures
  end

  describe "#shown_user_bookmark_page" do
    context "ページ指定なし" do
      it {
        @page.shown_user_bookmark_page
        WebMock.should have_requested(:get, BOOKMARK_PATH).with(:query => {:type => 'user', :p => '1', :rest => 'show'})
      }
    end

    context "ページ指定あり" do
      it {
        @page.shown_user_bookmark_page 2
        WebMock.should have_requested(:get, BOOKMARK_PATH).with(:query => {:type => 'user', :p => '2', :rest => 'show'})
      }
    end
  end

  describe "#hidden_user_bookmark_page" do
    context "ページ指定なし" do
      it {
        @page.hidden_user_bookmark_page
        WebMock.should have_requested(:get, BOOKMARK_PATH).with(:query => {:type => 'user', :p => '1', :rest => 'hide'})
      }
    end

    context "ページ指定あり" do
      it {
        @page.hidden_user_bookmark_page 2
        WebMock.should have_requested(:get, BOOKMARK_PATH).with(:query => {:type => 'user', :p => '2', :rest => 'hide'})
      }
    end
  end

  describe "#shown_users" do
    context "ページ指定なし" do
      it {
        users = @page.shown_users
        users.size.should eq 48
        users[0].login_id.should eq "id"
        users[0].password.should eq "password"
        users[0].agent.should eq @mech
        users[0].id.should eq "1"
      }
    end

    context "ページ指定あり" do
      it {
        users = @page.shown_users 2
        users.size.should eq 48
        users[0].login_id.should eq "id"
        users[0].password.should eq "password"
        users[0].agent.should eq @mech
        users[0].id.should eq "49"
      }
    end
  end

  describe "#hidden_users" do
    context "ページ指定なし" do
      it {
        users = @page.hidden_users
        users.size.should eq 48
        users[0].login_id.should eq "id"
        users[0].password.should eq "password"
        users[0].agent.should eq @mech
        users[0].id.should eq "101"
      }
    end

    context "ページ指定あり" do
      it {
        users = @page.hidden_users 2
        users.size.should eq 48
        users[0].login_id.should eq "id"
        users[0].password.should eq "password"
        users[0].agent.should eq @mech
        users[0].id.should eq "149"
      }
    end
  end
end
