class PixivMachine::IllustPage < PixivMachine::Page
  attr_reader :id

  def initialize(login_id, password, id, agent)
    super(login_id, passwod, agent)
    @users_id = use_id
  end
end
