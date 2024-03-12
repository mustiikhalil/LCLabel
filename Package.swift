// swift-tools-version:5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "LCLabel",
  platforms: [.iOS(.v13)],
  products: [
    .library(
      name: "LCLabel",
      targets: ["LCLabel"]),
  ],
  dependencies: [
    .package(
      url: "https://github.com/pointfreeco/swift-snapshot-testing",
      exact: "1.9.0"),
  ],
  targets: [
    .target(
      name: "LCLabel"),
    .testTarget(
      name: "LCLabelTests",
      dependencies: [
        "LCLabel",
        .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
      ]),
  ])
