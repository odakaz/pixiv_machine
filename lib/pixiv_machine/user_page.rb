class PixivMachine::UserPage < PixivMachine::Page
  attr_reader :id

  def initialize(agent, login_id, password, id)
    super(agent, login_id, password)
    @id = id
  end

  def illusts_page(page_number = 1)
    PixivMachine::IllustsPage.new(agent, login_id, password, id, page_number)
  end
end
