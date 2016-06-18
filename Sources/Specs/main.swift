import Speck

Speck.register([SampleSpec])
Speck.Reporter.listen(reporter)
try Speck.run()
