# -*- coding: utf-8 -*-
require 'spec_helper'
include PixivMachine::URL

describe PixivMachine::IllustPage do
  before {
    @mech = Mechanize.new
    setup_default_fixtures
  }

  describe "#overview" do
    before {
      @page = PixivMachine::IllustPage.new('id', 'password', '10000', @mech)
    }

    it {
      @page.overview
      WebMock.should have_requested(:get, USER_ILLUST_PATH).with(:query => {:mode => 'medium', :illust_id => '10000'})
    }
  end

  describe "#detail" do
    context "単品のイラスト" do
      before {
        @page = PixivMachine::IllustPage.new('id', 'password', '10000', @mech)
      }

      it {
        detail = @page.detail
        WebMock.should have_requested(:get, USER_ILLUST_PATH).with(:query => {:mode => 'medium', :illust_id => '10000'})
        detail.should be_an_instance_of PixivMachine::IllustDetailPage
      }
    end

    context "マンガ" do
      before {
        @page = PixivMachine::IllustPage.new('id', 'password', '20000', @mech)
      }

      it {
        detail = @page.detail
        WebMock.should have_requested(:get, USER_ILLUST_PATH).with(:query => {:mode => 'medium', :illust_id => '20000'})
        detail.should be_an_instance_of PixivMachine::MangaDetailPage
      }
    end

    context "存在しないイラストを指定された場合" do
      before {
        @page = PixivMachine::IllustPage.new('id', 'password', '30000', @mech)
      }

      it {
        detail = @page.detail

        detail.should be_nil
      }
    end
  end
end
