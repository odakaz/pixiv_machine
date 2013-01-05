# -*- coding: utf-8 -*-
require 'spec_helper'
include PixivMachine::URL

describe PixivMachine::UserPage do
  before do
    @mech = Mechanize.new
    @page = PixivMachine::UserPage.new("id", "password", "999", @mech)
    setup_default_fixtures
  end

  describe "#illust_page" do
    context "ページ指定なし" do
      it {
        @page.illust_page
        WebMock.should have_requested(:get, USER_ILLUST_PATH).with(:query => {:id => '999', :p => '1'})
      }
    end

    context "ページ指定あり" do
      it {
        @page.illust_page 2
        WebMock.should have_requested(:get, USER_ILLUST_PATH).with(:query => {:id => '999', :p => '2'})
      }
    end
  end

  describe "#illusts" do
    context "ページ指定なし" do
      it {
        illusts = @page.illusts

        illusts.size.should eq 48

        illusts.first.should be_an_instance_of PixivMachine::IllustPage
        illusts.first.login_id.should eq 'id'
        illusts.first.password.should eq 'password'
        illusts.first.id.should eq '1'
        illusts.first.agent.should eq @mech

        illusts.last.should be_an_instance_of PixivMachine::IllustPage
        illusts.last.login_id.should eq 'id'
        illusts.last.password.should eq 'password'
        illusts.last.id.should eq '48'
        illusts.last.agent.should eq @mech
      }
    end

    context "ページ指定あり" do
      it {
        illusts = @page.illusts 2

        illusts.size.should eq 10

        illusts.first.should be_an_instance_of PixivMachine::IllustPage
        illusts.first.login_id.should eq 'id'
        illusts.first.password.should eq 'password'
        illusts.first.id.should eq '49'
        illusts.first.agent.should eq @mech

        illusts.last.should be_an_instance_of PixivMachine::IllustPage
        illusts.last.login_id.should eq 'id'
        illusts.last.password.should eq 'password'
        illusts.last.id.should eq '58'
        illusts.last.agent.should eq @mech
      }
    end
  end
end
