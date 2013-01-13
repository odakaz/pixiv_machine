# -*- coding: utf-8 -*-
require 'spec_helper'
include PixivMachine::URL

describe PixivMachine::UserBookmarkPage do
  before do
    @mech = Mechanize.new
    setup_default_fixtures
  end

  describe "#new" do
    context "ページ指定されたら、カレントページが指定されたページ番号になる" do
      subject {PixivMachine::UserBookmarkPage.new(@mech, 'id', 'password', 'REST', 100)}
      its(:agent) {should eq @mech}
      its(:login_id) {should eql 'id'}
      its(:password) {should eql 'password'}
      its(:rest) {should eql 'REST'}
      its(:current_page_number) {should eq 100}
    end

    context "ページ指定されないなら、カレントページは1になる" do
      subject {PixivMachine::UserBookmarkPage.new(@mech, 'id', 'password', 'REST')}
      its(:agent) {should eq @mech}
      its(:login_id) {should eql 'id'}
      its(:password) {should eql 'password'}
      its(:rest) {should eql 'REST'}
      its(:current_page_number) {should eq 1}
    end
  end

  describe "#each_body" do
    before do
      @page = PixivMachine::UserBookmarkPage.new(@mech, 'id', 'password', :show, 2)
    end

    specify { expect { |b| @page.each_body(&b) }.to yield_successive_args(PixivMachine::UserBookmarkPage::Body, PixivMachine::UserBookmarkPage::Body, PixivMachine::UserBookmarkPage::Body) }
  end

  describe "#users" do
    context "公開ブックマーク" do
      context "ページ指定されたら、指定されたページをgetしてユーザーのリストを作る" do
        before do
          @page = PixivMachine::UserBookmarkPage.new(@mech, "id", "password", :show, 1)
        end

        subject {@page.users 2}
        its(:size) {should eq 48}
        its(:first) {should be_an_instance_of PixivMachine::UserPage}
        its('first.id') {should eql '49'}
        its(:last) {should be_an_instance_of PixivMachine::UserPage}
        its('last.id') {should eql '96'}

        it {
          @page.users 2
          WebMock.should have_requested(:get, BOOKMARK_PATH).with(:query => {:type => 'user', :rest => 'show', :p => 2})
        }
      end

      context "ページ指定されなかったら、現在のページをgetしてユーザーのリストを作る" do
        before do
          @page = PixivMachine::UserBookmarkPage.new(@mech, "id", "password", :show, 3)
        end

        subject {@page.users}
        its(:size) {should eq 10}
        its(:first) {should be_an_instance_of PixivMachine::UserPage}
        its('first.id') {should eql '97'}
        its(:last) {should be_an_instance_of PixivMachine::UserPage}
        its('last.id') {should eql '106'}

        it {
          @page.users
          WebMock.should have_requested(:get, BOOKMARK_PATH).with(:query => {:type => 'user', :rest => 'show', :p => 3})
        }
      end
    end
    context "非公開ブックマーク" do
      context "ページ指定されたら、指定されたページをgetしてユーザーのリストを作る" do
        before do
          @page = PixivMachine::UserBookmarkPage.new(@mech, "id", "password", :hide, 1)
        end
        
        subject {@page.users 2}
        its(:size) {should eq 48}
        its(:first) {should be_an_instance_of PixivMachine::UserPage}
        its('first.id') {should eql '1049'}
        its(:last) {should be_an_instance_of PixivMachine::UserPage}
        its('last.id') {should eql '1096'}

        it {
          @page.users 2
          WebMock.should have_requested(:get, BOOKMARK_PATH).with(:query => {:type => 'user', :rest => 'hide', :p => 2})
        }
      end

      context "ページ指定されなかったら、現在のページをgetしてユーザーのリストを作る" do
        before do
          @page = PixivMachine::UserBookmarkPage.new(@mech, "id", "password", :hide, 3)
        end

        subject {@page.users}
        its(:size) {should eq 10}
        its(:first) {should be_an_instance_of PixivMachine::UserPage}
        its('first.id') {should eql '1097'}
        its(:last) {should be_an_instance_of PixivMachine::UserPage}
        its('last.id') {should eql '1106'}

        it {
          @page.users
          WebMock.should have_requested(:get, BOOKMARK_PATH).with(:query => {:type => 'user', :rest => 'hide', :p => 3})
        }
      end
    end
  end

  describe "#has_next?" do
    context "次のページがあれば" do
      subject {PixivMachine::UserBookmarkPage.new(@mech, 'id', 'password', 'show', 1).has_next?}
      it {should eq true}
    end

    context "次のページがなければ" do
      subject {PixivMachine::UserBookmarkPage.new(@mech, 'id', 'password', 'show', 3).has_next?}
      it {should eq false}
    end
  end

  describe "#has_prev?" do
    context "前のページがあれば" do
      subject {PixivMachine::UserBookmarkPage.new(@mech, 'id', 'password', 'show', 3).has_prev?}
      it {should eq true}
    end

    context "前のページがなければ" do
      subject {PixivMachine::UserBookmarkPage.new(@mech, 'id', 'password', 'show', 1).has_prev?}
      it {should eq false}
    end
  end

  describe "#next" do
    context "次のページがある場合" do
      before do
        @page = PixivMachine::UserBookmarkPage.new(@mech, 'id', 'password', 'show', 1)
      end

      it {
        @page.next
        WebMock.should have_requested(:get, BOOKMARK_PATH).with(:query => {:type => 'user', :rest => 'show', :p => 2})

        @page.current_page_number.should eq 2
      }
    end

    context "次のページがない場合" do
      before do
        @page = PixivMachine::UserBookmarkPage.new(@mech, 'id', 'password', 'show', 3)
      end

      it {
        @page.next
        WebMock.should_not have_requested(:get, BOOKMARK_PATH).with(:query => {:type => 'user', :rest => 'show', :p => 4})

        @page.current_page_number.should eq 3
      }
    end
  end

  describe "#prev" do
    context "前のページがある場合" do
      before do
        @page = PixivMachine::UserBookmarkPage.new(@mech, 'id', 'password', 'show', 3)
      end

      it {
        @page.prev
        WebMock.should have_requested(:get, BOOKMARK_PATH).with(:query => {:type => 'user', :rest => 'show', :p => 2})

        @page.current_page_number.should eq 2
      }
    end

    context "前のページがない場合" do
      before do
        @page = PixivMachine::UserBookmarkPage.new(@mech, 'id', 'password', 'show', 1)
      end

      it {
        @page.prev
        WebMock.should_not have_requested(:get, BOOKMARK_PATH).with(:query => {:type => 'user', :rest => 'show', :p => 0})

        @page.current_page_number.should eq 1
      }
    end
  end
end
