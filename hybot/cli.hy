(import argparse)

(defclass Cli []
	"Cli helper for hybot"
	
	(defn __init__ [self]
		(setv parser (argparse.ArgumentParser :description "Hybot"))
		(parser.add-argument "--main"
			:metavar "--m"
			:type str
			:default "y"
			:help "Run the main function")
		(parser.add-argument "--verbose"
			:metavar "--v"
			:type str
			:default "n"
			:help "Run in verbose mode")
		(parser.add-argument "--token"
			:metavar "--t"
			:type str
			:help "Pass a token as an argument instead of pulling an environment variable")
		
		(setv self._args (parser.parse-args))
		(return))
	
	#@(property (defn args [self]
		(return self._args)))
	
	(defn ^bool is-main [self]
		(if (is-yes self.args.main)
			(return True)
			(return False)))
	
	(defn ^bool is-verbose [self]
		(if (is-yes self.args.verbose)
			(return True)
			(return False)))
	
	(defn ^bool has-token [self]
		(if (not (= self.args.token None))
			(return True)
			(return False))))

(defn ^bool is-yes [text]
	(setv text (text.lower))
	(if (or (= text "y") (= text "yes"))
		(return True)
		(return False)))
