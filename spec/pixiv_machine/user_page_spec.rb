# -*- coding: utf-8 -*-
require 'spec_helper'
include PixivMachine::URL

describe PixivMachine::UserPage do
  before do
    @mech = Mechanize.new
    @page = PixivMachine::UserPage.new(@mech, "id", "password", "999")
    setup_default_fixtures
  end

  describe "#illusts_page" do
    context "ページ指定なし" do
      subject {@page.illusts_page}
      it {should be_an_instance_of PixivMachine::IllustsPage}
      its(:current_page_number) {should eq 1}
    end

    context "ページ指定あり" do
      subject {@page.illusts_page 2}
      it {should be_an_instance_of PixivMachine::IllustsPage}
      its(:current_page_number) {should eq 2}
    end
  end
end
