import XTest
import Core

class SampleSpec: Group {
  let myFirstTest = Test { assert in
    assert.that(Sample.greeting(), equals: "Hello, world!")
  }
}
