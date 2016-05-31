import PackageDescription

let package = Package(
  targets: [
    Target(name: "Core"),
    Target(name: "Main", dependencies: [.Target(name: "Core")]),
    Target(name: "CoreTest", dependencies: [.Target(name: "Core")])
  ],
  dependencies: [
    .Package(url: "https://github.com/hkgumbs/XTest.git", Version(0,1,1))
  ]
)
