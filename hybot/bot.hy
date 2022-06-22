(import discord)
(import random [randint])

(setv client (discord.Client))
(setv is-verbose False)

(defn ^None setup [^bool p-is-verbose]
	(global is-verbose)
	(setv is-verbose p-is-verbose))

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
	
	(cond
		[(= text "hello")
			(return (hello))]
		[(= text "repo")
			(return (repo))]
		[(= text "hy")
			(return (hy))]
		[(= text "roll")
			(return (roll split-text))])
	
	(return "Invalid command"))

(defn ^str hello []
	(return "Hello!"))

(defn ^str repo []
	(return "https://github.com/you-win/hybot"))

(defn ^str hy []
	(return "https://github.com/hylang/hy"))

(defn ^str roll [^str split-text]
	(setv ^int num 6)
	(if (>= (len split-text) 2)
		(do
			(setv input-number (get split-text 1))
			(if (input-number.isdigit)
				(setv num (int input-number)))))
	
	(return (str (randint 1 num))))
