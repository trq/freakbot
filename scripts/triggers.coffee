# Commands:
#   !<trigger> - Display response to intended user
#
# Notes:
#   Add helpful triggers when you think of them!

triggers =
  # Question Assistance
  '!dataja'       : "Don't ask to ask, Just ask!"
  '!tryit'        : "Try it and see™. You learn much more by experimentation than by asking without having even tried."
  '!question'      : "Before asking for help, use http://forums.phpfreaks.com to provide us with all the relevant code and a good description of your issue. Paste the link here when done. Thanks!"
  '!paste'        : "Please post your code on https://gist.github.com and paste the link here."
  '!pb'           : "Please avoid using pastebin.com as it is slow and forces others to look at ads. Please use https://gist.github.com.au. Thanks!"
  '!help'         : "See http://phpfreaks.com/page/irc-live-chat for help using our irc channel."

  # Helpers
  '!ugt'          : "It is always morning when someone comes into a channel. We call that Universal Greeting Time http://www.total-knowledge.com/~ilya/mips/ugt.html"
  '!nick'         : "Hello! You're currently using a nick that's difficult to distinguish. Please type in \"/nick your_name\" so we can easily identify you"
  '!welcome'      : "Hello, I'm #{process.env.HUBOT_IRC_NICK}, the PHPFreaks IRC Bot!  Welcome to #help :).  If you have any questions, type !help to see how to best ask for assistance.  If you need to paste code, check !paste for more info.  Thanks!"
  '!whoisfoobot'  : "Hello! The PHPFreaks team created me to help you! You can find my code at https://github.com/trq/freakbot"

module.exports = (robot) ->
  robot.hear /(([^:\s!]+)[:\s]+)?(!\w+)(.*)/i, (msg) ->
    user          = msg.match[2]
    trigger       = msg.match[3]
    args          = msg.match[4]
    triggerPhrase = triggers[trigger]

    if triggerPhrase
      if user?
        msg.send "#{user}: #{triggerPhrase}"
      else
        msg.reply triggerPhrase
