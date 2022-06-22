(import sys)
(import discord)
(import random [randint])

(setv client (discord.Client))
(setv is-verbose False)
(setv bot None)

(defn ^None setup [^bool p-is-verbose]
	(global is-verbose)
	(setv is-verbose p-is-verbose)

	(global bot)
	(setv bot (get sys.modules __name__)))

#@(client.event (defn/a on-ready []
	(print "bot ready!")))
	
#@(client.event (defn/a on-message [message]
	(if (= message.author client.user)
		(return))
	
	(if (not (message.content.startswith "?"))
		(return))

	(if is-verbose
		(print "Trying to handle message"))
	
	(await (message.channel.send (handle-message message)))))

(defn run [token]
	(if is-verbose
		(print "Running bot"))

	(client.run token))

(defn handle-message [message]
	(setv text (cut message.content 1 (len message.content)))

	(if is-verbose
		(print text))

	(setv split-text (text.split " "))
	(setv text (get split-text 0))

	(if (hasattr bot text)
		(return ((getattr bot text) split-text))
		(return "Invalid command")))

(defn ^str hello [^str args]
	(return "Hello!"))

(defn ^str repo [^str args]
	(return "https://github.com/you-win/hybot"))

(defn ^str hy [^str args]
	(return "https://github.com/hylang/hy"))

(defn ^str roll [^str args]
	(setv ^int num 6)
	(if (>= (len args) 2)
		(do
			(setv input-number (get args 1))
			(if (input-number.isdigit)
				(setv num (int input-number)))))
	
	(return (str (randint 1 num))))
