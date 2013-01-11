# -*- coding: utf-8 -*-
class PixivMachine::PageablePage < PixivMachine::Page
  attr_reader :current_page_number

  def initialize(agent, login_id, password, page_number = 1)
    super(agent, login_id, password)
    @current_page_number = page_number
  end

  def has_next?
    raise 'has_next? is not implemented!'
  end

  def has_prev?
    raise 'has_prev? is not implemented!'
  end

  def next
    nth_page(current_page_number + 1) if has_next?
    self
  end

  # 指定したページに移動する
  def nth_page(page_number)
    @current_page_number = page_number
    get(page_to_uri(page_number))
    self
  end

  def current
    nth_page(current_page_number)
  end

  def prev
    nth_page(current_page_number - 1) if has_prev?
    self
  end

  private
  def page_to_uri(page_number)
    railse 'page_to_uri is not implemented!'
  end
end
