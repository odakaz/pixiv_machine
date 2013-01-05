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

        users.first.login_id.should eq "id"
        users.first.password.should eq "password"
        users.first.agent.should eq @mech
        users.first.id.should eq "1"

        users.last.login_id.should eq "id"
        users.last.password.should eq "password"
        users.last.agent.should eq @mech
        users.last.id.should eq "48"
      }
    end

    context "ページ指定あり" do
      it {
        users = @page.shown_users 2

        users.size.should eq 48

        users.first.login_id.should eq "id"
        users.first.password.should eq "password"
        users.first.agent.should eq @mech
        users.first.id.should eq "49"

        users.last.login_id.should eq "id"
        users.last.password.should eq "password"
        users.last.agent.should eq @mech
        users.last.id.should eq "96"
      }
    end
  end

  describe "#hidden_users" do
    context "ページ指定なし" do
      it {
        users = @page.hidden_users
        users.size.should eq 48

        users.first.login_id.should eq "id"
        users.first.password.should eq "password"
        users.first.agent.should eq @mech
        users.first.id.should eq "101"

        users.last.login_id.should eq "id"
        users.last.password.should eq "password"
        users.last.agent.should eq @mech
        users.last.id.should eq "148"
      }
    end

    context "ページ指定あり" do
      it {
        users = @page.hidden_users 2
        users.size.should eq 48

        users.first.login_id.should eq "id"
        users.first.password.should eq "password"
        users.first.agent.should eq @mech
        users.first.id.should eq "149"

        users.last.login_id.should eq "id"
        users.last.password.should eq "password"
        users.last.agent.should eq @mech
        users.last.id.should eq "196"
      }
    end
  end
end
