(import os)
(import discord)

(setv client (discord.Client))

#@(client.event (defn/a on-ready[]
	(print "hello")))

#@(client.event (defn/a on-message [message]
	(if (= message.author client.user)
		(return))

	(if (message.content.startswith "!hello")
		(await (message.channel.send "hello!")))))

(defn main []
	(setv token (os.environ.get "HYBOT_DISCORD_TOKEN"))
	
	(client.run token))

(if (= __name__ "__main__")
	(main))
