// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
let package = Package(
	name: "fcikernel",
	products: [
		.plugin(
			name: "ci.metal",
			targets: ["ci.metal"]
        ),
	],
	targets: [
		.plugin(
			name: "ci.metal",
			capability: .buildTool,
			path: "ci.metal"
		)
	]
)
