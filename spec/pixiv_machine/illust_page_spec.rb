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
end
