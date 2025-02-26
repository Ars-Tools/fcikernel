import Foundation
import PackagePlugin
@main
struct PlugIn: BuildToolPlugin {
	func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
		guard let target = target as?SourceModuleTarget else { return.init() }
		return createBuildCommands(directory: context.pluginWorkDirectoryURL,
								   sources: target.sourceFiles(withSuffix: "ci.metal").map(\.url))
	}
}
#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin
extension PlugIn: XcodeBuildToolPlugin {
	func createBuildCommands(directory: URL, sources: Array<URL>) -> Array<Command> {
		guard !sources.isEmpty else { return.init() }
		let output = directory.appending(component: "ci").appendingPathExtension("metallib")
		return [
			.buildCommand(
				displayName: "xcrun",
				executable: .init(filePath: "/usr/bin/xcrun"),
				arguments: [
					"metal",
					"-fmodules-cache-path=\(directory.path())",
					"-fcikernel",
					"-o",
					output.path(),
				] + sources.map { $0.path() },
				environment: [:],
				inputFiles: sources,
				outputFiles: [output])
		]
	}
	func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [Command] {
		guard let target = target as?SourceModuleTarget else { return.init() }
		return createBuildCommands(directory: context.pluginWorkDirectoryURL,
								   sources: target.sourceFiles(withSuffix: "ci.metal").map(\.url))
	}
}
#else
extension PlugIn {
	func createBuildCommands(directory: URL, sources: Array<URL>) -> Array<Command> {
		[]
	}
}
#endif
