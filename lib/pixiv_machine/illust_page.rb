class PixivMachine::IllustPage < PixivMachine::Page
  attr_reader :id

  def initialize(login_id, password, id, agent)
    super(login_id, password, agent)
    @id = id
  end
end
