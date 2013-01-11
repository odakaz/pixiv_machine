# -*- coding: utf-8 -*-
require 'spec_helper'

describe PixivMachine::Page do
  before do
    @mech = Mechanize.new
    @page = PixivMachine::Page.new(@mech, "id", "password")
    setup_default_fixtures
  end

  describe "#new" do
    subject {@page}
    its(:login_id) {should == "id"}
    its(:password) {should == "password"}
    its(:agent) {should == @mech}
  end

  describe "#login" do
    context "ログイン失敗" do
      subject {lambda{@page.login}}
      before do
        WebMock.stub_request(:any, LOGIN_PATH).
          to_return(:status => 200, 
                    :headers => {'Content-Type' => 'text/html'},
                    :body => File.new("#{FIXTURE_ROOT}/login"))
      end
      it {should raise_error PixivMachine::LoginError}
    end

    context "ログイン成功" do
      subject {@page.login}
      its("page.uri.request_uri") {should =~ /mypage\.php/}
    end
  end
end
