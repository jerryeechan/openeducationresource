class ChatController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    puts 'init chat'
    controller_store[:message_count] = 0
  end

  def message
    puts 'event triggered'
    test_message = {:message => 'this is a message'}
    broadcast_message :test_message, test_message
  end
  def connected
    puts 'connected'
    test_message = {:message => 'this is a message'}
    broadcast_message :test_message, test_message
  end
end