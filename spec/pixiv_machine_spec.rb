# -*- coding: utf-8 -*-
require 'pixiv_machine'

describe PixivMachine  do
  before do
    @pixiv_machine = PixivMachine.new("id", "pass")
  end

  describe "#new" do
    subject {@pixiv_machine.my_page}
    it {should_not be_nil}
    its(:class) {should == PixivMachine::MyPage }
  end
end
