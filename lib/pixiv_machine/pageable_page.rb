# -*- coding: utf-8 -*-
class PixivMachine::PageablePage < PixivMachine::Page
  attr_reader :current_page_number

  def has_next?
    raise 'has_next? is not implemented!'
  end

  def has_prev?
    raise 'has_prev? is not implemented!'
  end

  def next
    raise 'next is not implemented!'
  end

  def prev
    raise 'prev is not implemented!'
  end
end
