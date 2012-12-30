class PixivMachine::Member < PixivMachine::Base
  attr_reader :id

  def initialize(id, agent)
    super(agent)
    @id = id
  end
end
