// swift-tools-version:5.1

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
             from: "0.2.1")
  ],
  targets: [
    .target(name: "AvocadoToast", dependencies: [ "SwiftWebUI" ])
  ]
)
