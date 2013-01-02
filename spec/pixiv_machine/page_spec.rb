# -*- coding: utf-8 -*-
require 'pixiv_machine'

describe PixivMachine::Page do
  before do
    @mech = Mechanize.new
    @page = PixivMachine::Page.new("id", "password", @mech)
  end

  describe "#new" do
    subject {@page}
    its(:login_id) {should == "id"}
    its(:password) {should == "password"}
    its(:agent) {should == @mech}
  end

  context "ログイン失敗" do
  end
end
