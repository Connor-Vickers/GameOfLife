import XTest
import Core

class SampleTest: Spec {
  let myFirstTest = Test { assert in
    assert.that(greeting(), equals: "Hello, world!")
  }
}
