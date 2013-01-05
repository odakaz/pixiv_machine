# -*- coding: utf-8 -*-
require 'spec_helper'
include PixivMachine::URL

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

  describe "#login" do
    before do 
      WebMock.stub_request(:get, INDEX_PATH).
        to_return(:status => 200,
                  :headers => {'Content-Type' => 'text/html'},
                  :body => File.new("#{FIXTURE_ROOT}/index"))
    end

    subject {lambda{@page.login}}

    context "ログイン失敗" do
      before do
        WebMock.stub_request(:any, LOGIN_PATH).
          to_return(:status => 200, 
                    :headers => {'Content-Type' => 'text/html'},
                    :body => File.new("#{FIXTURE_ROOT}/login"))
      end
      it {should raise_error PixivMachine::LoginError}
    end

    context "ログイン成功" do
      before do
        WebMock.stub_request(:any, LOGIN_PATH).
          to_return(:status => 302, 
                    :headers => {'Location' => MYPAGE_PATH})

        WebMock.stub_request(:any, MYPAGE_PATH).
          to_return(:status => 200,
                    :headers => {'Content-Type' => 'text/html'},
                    :body => File.new("#{FIXTURE_ROOT}/mypage"))
      end
      it {@page.login.page.uri.request_uri.should =~ /mypage\.php/}
    end
  end
end
