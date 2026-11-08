// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "AvocadoToast",
  platforms: [
    .macOS(.v10_15), .iOS(.v13)
  ],
  products: [
    .executable(name: "AvocadoToast", targets: [ "AvocadoToast" ])
  ],
  dependencies: [
    .package(url: "https://github.com/SwiftWebUI/SwiftWebUI.git",
             from: "0.4.1")
  ],
  targets: [
    .executableTarget(name: "AvocadoToast", dependencies: [ "SwiftWebUI" ])
  ]
)
