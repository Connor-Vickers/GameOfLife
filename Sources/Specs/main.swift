import Speck

Speck.register([GridSpec])
Speck.Reporter.listen(reporter)
try Speck.run()
