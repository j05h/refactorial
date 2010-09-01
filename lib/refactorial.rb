require 'rubygems'
require 'xmpp4r-simple'
require 'gist'

class Refactorial
  VERSION = '1.0.0'
end

#Jabber::debug = true

#im = Jabber::Simple.new("refac7orial@gmail.com", "kl3inp3t3r")
#
#im.presence_updates do |update|
#  from     = update[0].jid.strip.to_s
#  status   = update[2].status
#  presence = update[2].show
#  puts "#{from} went #{presence}: #{status}"
#end
#
#im.deliver("dorkus@gmail.com", "I have a gist for you!")
#
#im.received_messages { |msg| puts msg.body if msg.type == :chat }
#
#sleep 1
#
