class PixivMachine::IllustPage < PixivMachine::Page
  attr_reader :id

  def initialize(id, agent)
    super(agent)
    @id = id
  end
end
