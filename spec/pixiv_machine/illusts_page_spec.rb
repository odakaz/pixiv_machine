# -*- coding: utf-8 -*-
require 'spec_helper'
include PixivMachine::URL

describe PixivMachine::IllustsPage do
  before do
    @mech = Mechanize.new
    @page = PixivMachine::IllustsPage.new(@mech, "id", "password", "999")
    setup_default_fixtures
  end

  describe "#illusts" do
    context "ページ指定なし" do
      it {
        illusts = @page.illusts
        WebMock.should have_requested(:get, USER_ILLUST_PATH).with(:query => {:id => '999', :p => '1'})
        illusts.size.should eq 48
      }
    end

    context "ページ指定あり" do 
      it {
        illusts = @page.illusts 2
        WebMock.should have_requested(:get, USER_ILLUST_PATH).with(:query => {:id => '999', :p => '2'})
        illusts.size.should eq 10
      }
    end
  end
end
