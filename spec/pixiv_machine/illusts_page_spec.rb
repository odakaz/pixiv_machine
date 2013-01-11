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
      subject {@page.illusts}
      its(:size) {should eq 48}
      its(:first) {should be_an_instance_of PixivMachine::Content}
      its(:last) {should be_an_instance_of PixivMachine::Content}

      it {
        @page.illusts
        WebMock.should have_requested(:get, USER_ILLUST_PATH).with(:query => {:id => '999', :p => '1'})
      }
    end

    context "ページ指定あり" do 
      subject {@page.illusts 2}
      its(:size) {should eq 10}
      its(:first) {should be_an_instance_of PixivMachine::Content}
      its(:last) {should be_an_instance_of PixivMachine::Content}

      it {
        @page.illusts 2
        WebMock.should have_requested(:get, USER_ILLUST_PATH).with(:query => {:id => '999', :p => '2'})
      }
    end
  end
end
