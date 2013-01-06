# -*- coding: utf-8 -*-
require 'spec_helper'

include PixivMachine::URL

describe PixivMachine::MangaDetailPage do
  before {
    @mech = Mechanize.new
    setup_default_fixtures
  }

  describe "#contents" do
    context "正常系" do
      before {
        @page = PixivMachine::MangaDetailPage.new('id', 'password', '20000', @mech)
      }

      it {
        contents = @page.contents
        WebMock.should have_requested(:get, USER_ILLUST_PATH).with(:query => {:mode => 'manga', :illust_id => '20000'})

        contents.size.should eq 3

        contents.each {|c|
          c.should be_an_instance_of PixivMachine::Content
          c.src.should match /http:\/\/xx\.yyyyy\.net\/aaaa\/bbb\/bbbbbbb\/20000_p*/
        }
      }
    end

    context "存在しないマンガを指定された場合" do
      before {
        @page = PixivMachine::MangaDetailPage.new('id', 'password', '30000', @mech)
      }
      
      subject {@page.contents.size}
      it {
        should eq 0
      }
    end
  end
end
