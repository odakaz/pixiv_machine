# -*- coding: utf-8 -*-
require 'spec_helper'

describe PixivMachine::MyPage do
  before do
    @mech = Mechanize.new
    @page = PixivMachine::MyPage.new(@mech, "id", "password")
    setup_default_fixtures
  end

  describe "#shown_user_bookmark_page" do
    context "ページ指定あり" do
      subject {@page.shown_user_bookmark_page 2}
      it {should be_an_instance_of PixivMachine::UserBookmarkPage}
      its(:rest) {should eq 'show'}
      its(:current_page_number) {should eq 2}
    end

    context "ページ指定なし" do
      subject {@page.shown_user_bookmark_page}
      it {should be_an_instance_of PixivMachine::UserBookmarkPage}
      its(:rest) {should eq 'show'}
      its(:current_page_number) {should eq 1}
    end
  end

  describe "#hidden_user_bookmark_page" do
    context "ページ指定あり" do
      subject {@page.hidden_user_bookmark_page 2}
      it {should be_an_instance_of PixivMachine::UserBookmarkPage}
      its(:rest) {should eq 'hide'}
      its(:current_page_number) {should eq 2}
    end

    context "ページ指定なし" do
      subject {@page.hidden_user_bookmark_page}
      it {should be_an_instance_of PixivMachine::UserBookmarkPage}
      its(:rest) {should eq 'hide'}
      its(:current_page_number) {should eq 1}
    end
  end

  describe "#user_bookmark_page" do
    subject {@page.user_bookmark_page 'REST', 10}
    it {should be_an_instance_of PixivMachine::UserBookmarkPage}
    its(:rest) {should eq 'REST'}
    its(:current_page_number) {should eq 10}
  end
end
