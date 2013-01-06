# -*- coding: utf-8 -*-
require 'spec_helper'

include PixivMachine::URL

describe PixivMachine::IllustDetailPage do
  before {
    @mech = Mechanize.new
    setup_default_fixtures
  }

  describe "#contents" do
    context "正常系" do
      before {
        @page = PixivMachine::IllustDetailPage.new('id', 'password', '10000', @mech)
      }

      it {
        contents = @page.contents
        WebMock.should have_requested(:get, USER_ILLUST_PATH).with(:query => {:mode => 'big', :illust_id => '10000'})

        contents.size.should eq 1
        contents.first.should be_an_instance_of PixivMachine::Content
        contents.first.src.should eq 'http://xxx.yyyy.net/aaaa/bbb/cccccc/10000.jpg'
      }
    end

    context "存在しないイラストを指定された場合" do
      before {
        @page = PixivMachine::IllustDetailPage.new('id', 'password', '30000', @mech)
      }
      
      subject {@page.contents.size}
      it {
        should eq 0
      }
    end
  end
end
