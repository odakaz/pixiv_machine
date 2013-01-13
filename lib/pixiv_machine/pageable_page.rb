# -*- coding: utf-8 -*-
class PixivMachine::PageablePage < PixivMachine::Page
  attr_reader :current_page_number

  def initialize(agent, login_id, password, page_number = 1)
    super(agent, login_id, password)
    @current_page_number = page_number
  end

  def has_next?
    current
    check_has_next
  end

  def has_prev?
    current
    check_has_prev
  end

  def current
    nth_page(current_page_number) unless page
  end

  def next
    nth_page(current_page_number + 1) if has_next?
    self
  end

  def prev
    nth_page(current_page_number - 1) if has_prev?
    self
  end

  def each_body(&block)
    nth_page(1)

    yield(page_body(page))

    while has_next?
      self.next
      yield(page_body(page))
    end
  end

  # 指定したページに移動する
  def nth_page(page_number)
    @current_page_number = page_number
    get(page_to_uri(page_number))
    self
  end

  private
  def page_to_uri(page_number)
    raise 'page_to_uri is not implemented!'
  end

  def page_body(page)
    raise 'page_body is not implemented!'
  end

  def check_has_next
    raise 'check_has_next is not implemented!'
  end

  def check_has_prev
    raise 'check_has_prev is not implemented!'
  end
end
