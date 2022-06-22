(import os)
(import discord)

(import cli [Cli])
(import bot)

(defn main [cli]
	(if (cli.has-token)
		(setv token cli.args.token)
		(setv token (os.environ.get "HYBOT_DISCORD_TOKEN")))
	
	(bot.setup cli.is-verbose)

	(bot.run token))

(if (= __name__ "__main__")
	(do
		(setv cli (Cli))

		(if (cli.is-main)
			(main cli))))
