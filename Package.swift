// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
let package = Package(
	name: "fcikernel",
	products: [
		.plugin(
			name: "fcikernel",
			targets: ["ci.metal"]),
	],
	targets: [
		.plugin(
			name: "ci.metal",
			capability: .buildTool,
			path: "ci.metal"
		)
	]
)
