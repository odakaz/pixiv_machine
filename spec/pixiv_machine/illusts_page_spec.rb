# -*- coding: utf-8 -*-
require 'spec_helper'
include PixivMachine::URL

describe PixivMachine::IllustsPage do
  before do
    @mech = Mechanize.new
    setup_default_fixtures
  end

  describe "#new" do
    before do
      @page = PixivMachine::IllustsPage.new(@mech, 'id', 'password', '999', 2)
    end

    context "ページ指定あり" do
      subject {@page}
      it {should be_an_instance_of PixivMachine::IllustsPage}
      its(:agent) {should eq @mech}
      its(:login_id) {should eql 'id'}
      its(:password) {should eql 'password'}
      its(:user_id) {should eql '999'}
      its(:current_page_number) {should eq 2}
    end

    context "ページ指定なし" do
      before do
        @page = PixivMachine::IllustsPage.new(@mech, 'id', 'password', '999')
      end
      subject {@page}
      it {should be_an_instance_of PixivMachine::IllustsPage}
      its(:agent) {should eq @mech}
      its(:login_id) {should eql 'id'}
      its(:password) {should eql 'password'}
      its(:user_id) {should eql '999'}
      its(:current_page_number) {should eq 1}
    end
  end

  describe "#has_next?" do
    context "次ページがある場合" do
      before do
        @page = PixivMachine::IllustsPage.new(@mech, 'id', 'password', '999', 1)
      end

      subject {@page.has_next?}
      it {should eq true}
    end

    context "次ページがない場合" do
      before do
        @page = PixivMachine::IllustsPage.new(@mech, 'id', 'password', '999', 3)
      end

      subject {@page.has_next?}
      it {should eq false}
    end
  end

  describe "#has_prev?" do
    context "前ページがある場合" do
      before do
        @page = PixivMachine::IllustsPage.new(@mech, 'id', 'password', '999', 2)
      end

      subject {@page.has_prev?}
      it {should eq true}
    end

    context "前ページがない場合" do
      before do
        @page = PixivMachine::IllustsPage.new(@mech, 'id', 'password', '999', 1)
      end

      subject {@page.has_prev?}
      it {should eq false}
    end
  end

  describe "#next" do
    context "次ページがある場合" do
      before do
        @page = PixivMachine::IllustsPage.new(@mech, 'id', 'password', '999', 1)
      end

      it {
        @page.next
        WebMock.should have_requested(:get, USER_ILLUST_PATH).with(:query => {:id => '999', :p => '2'})

        @page.current_page_number.should eq 2
      }
    end

    context "次ページがない場合" do
      before do
        @page = PixivMachine::IllustsPage.new(@mech, 'id', 'password', '999', 3)
      end
      it {
        @page.next
        WebMock.should_not have_requested(:get, USER_ILLUST_PATH).with(:query => {:id => '999', :p => '4'})

        @page.current_page_number.should eq 3
      }
    end
  end

  describe "#prev" do
    context "前ページがある場合" do
      before do
        @page = PixivMachine::IllustsPage.new(@mech, 'id', 'password', '999', 3)
      end
      it {
        @page.prev
        WebMock.should have_requested(:get, USER_ILLUST_PATH).with(:query => {:id => '999', :p => '2'})

        @page.current_page_number.should eq 2
      }
    end

    context "前ページがない場合" do
      before do
        @page = PixivMachine::IllustsPage.new(@mech, 'id', 'password', '999', 1)
      end
      it {
        @page.prev
        WebMock.should_not have_requested(:get, USER_ILLUST_PATH).with(:query => {:id => '999', :p => '0'})

        @page.current_page_number.should eq 1
      }
    end
  end

  describe "#illusts" do
    before do
      @page = PixivMachine::IllustsPage.new(@mech, 'id', 'password', '999', 1)
    end

    context "ページ指定なし" do
      subject {@page.illusts}
      its(:size) {should eq 20}
      its(:first) {should be_an_instance_of PixivMachine::Content}
      its('first.id') {should eq '1'}
      its(:last) {should be_an_instance_of PixivMachine::Content}
      its('last.id') {should eq '20'}

      it {
        @page.illusts
        WebMock.should have_requested(:get, USER_ILLUST_PATH).with(:query => {:id => '999', :p => '1'})
        @page.current_page_number.should eq 1
      }
    end

    context "ページ指定あり" do 
      subject {@page.illusts 3}
      its(:size) {should eq 7}
      its(:first) {should be_an_instance_of PixivMachine::Content}
      its('first.id') {should eq '41'}
      its(:last) {should be_an_instance_of PixivMachine::Content}
      its('last.id') {should eq '47'}

      it {
        @page.illusts 3
        WebMock.should have_requested(:get, USER_ILLUST_PATH).with(:query => {:id => '999', :p => '3'})
        @page.current_page_number.should eq 3
      }
    end
  end
end
