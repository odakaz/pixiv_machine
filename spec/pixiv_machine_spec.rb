# -*- coding: utf-8 -*-
require 'pixiv_machine'

describe PixivMachine  do
  before do
    @pixiv_machine = PixivMachine.new("id", "pass")
  end

  describe "#new" do
    subject {@pixiv_machine.my_page}
    it {should_not be_nil}
    it {should be_an_instance_of PixivMachine::MyPage}
    its(:login_id) {should eq 'id'}
    its(:password) {should eq 'pass'} 
  end
end
