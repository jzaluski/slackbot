# use karl's chat-adapter library
require 'chat-adapter'
# also use the local HerokuSlackbot class defined in heroku.rb
require './heroku'

# if we're on our local machine, we want to test our bot via shell, but when on
# heroku, deploy the actual slackbot.
# 
# Feel free to change the name of the bot here - this controls what name the bot
# uses when responding.
if ARGV.first == 'heroku'
  bot = HerokuSlackAdapter.new(nick: 'aeropress')
else
  bot = ChatAdapter::Shell.new(nick: 'aeropress')
end

# Feel free to ignore this - makes logging easier
log = ChatAdapter.log

# Do this thing in this block each time the bot hears a message:
bot.on_message do |message, info|
  # ignore all messages not directed to this bot
  if message.include? ':coffee:'
    
    # split the message in 2 to get what was actually said.
    botname, command = message.split(': ', 2)

    # answer the query!
    # this bot simply echoes the message back
    "@#{info[:user]}: #{':coffee:!!!'}"
  end
end

# actually start the bot
bot.start!
