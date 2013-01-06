require_relative 'content'

class PixivMachine::DetailPage < PixivMachine::Page
  attr_reader :id

  def initialize(login_id, password, id, agent)
    super(login_id, password, agent)
    @id = id
  end

  def contents
    nil
  end

  private
  def build_content(img)
    content = PixivMachine::Content.new
    content.src = img[:src]
    content
  end
end
