// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Observation",
	products: [
		.library(
			name: "Observation",
			targets: ["Observation"]),
	],
	dependencies: [
		
	],
	targets: [
		.target(
			name: "Observation",
			dependencies: []),
		.testTarget(
			name: "ObservationTests",
			dependencies: ["Observation"]),
	]
)
