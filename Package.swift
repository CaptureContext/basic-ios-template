// swift-tools-version: 6.2

import PackageDescription

let package = Package(
	name: "app-package",
	platforms: [
		.iOS(.v26),
	],
	dependencies: [
		.package(path: "./Dependencies"),
		.package(path: "./Extensions"),
		.package(
			url: "https://github.com/capturecontext/spmgen.git",
			from: "3.1.0"
		),
	],
	producibleTargets: [

		// MARK: - A

		.target(
			name: "AppFeature",
			product: .library(.static),
			dependencies: [
				.target(name: "MainFeature"),
			]
		),

		.target(
			name: "AppUI",
			product: .library(.static),
			dependencies: [
				.localUIExtensions,
				.dependency("_CocoaNavigation"),
				.dependency("_PackageResources"),
			],
			resources: [
				.process("Resources"),
			],
			plugins: [
				.spmgen,
			]
		),

		// MARK: - M

		.target(
			name: "MainFeature",
			product: .library(.static),
			dependencies: [
				.target(name: "AppUI"),
			]
		),
	]
)

// MARK: - Helpers

extension Package.Dependency {
	static func fork(_ package: String) -> Package.Dependency {
		.package(path: "./Forks/\(package)")
	}
}

extension Target.Dependency {
	static var localExtensions: Target.Dependency {
		.extensions("LocalExtensions")
	}

	static var localUIExtensions: Target.Dependency {
		.extensions("LocalUIExtensions")
	}

	static func extensions(_ product: String) -> Target.Dependency {
		.product(name: product, package: "Extensions")
	}

	static func dependency(_ name: String, condition: TargetDependencyCondition? = nil) -> Target.Dependency {
		.product(name: name, package: "Dependencies", condition: condition)
	}

	static func target(_ name: String, condition: TargetDependencyCondition? = nil) -> Target.Dependency {
		.target(name: name, condition: condition)
	}
}

extension Target.PluginUsage {
	static var spmgen: Self {
		.plugin(name: "spmgen-plugin", package: "spmgen")
	}
}

struct CustomTargetPathBuilder: ExpressibleByStringLiteral {
	private let build: (String) -> String

	func build(for targetName: String) -> String {
		build(targetName)
	}

	init(_ build: @escaping (String) -> String) {
		self.build = build
	}

	init(_ value: String) {
		self.init { _ in value }
	}

	init(stringLiteral value: String) {
		self.init(value)
	}

	static var targetName: Self {
		return .init { $0 }
	}

	func map(_ transform: @escaping (String) -> String) -> Self {
		return .init { transform(self.build(for: $0)) }
	}

	func nestedInSources() -> Self {
		return nested(in: "Sources")
	}

	func nesting(_ child: String?) -> Self {
		return map { path in
			child.map { "\(path)/\($0)" } ?? path
		}
	}

	func nested(in parent: String) -> Self {
		return map { "\(parent)/\($0)" }
	}

	func suffixed(by suffix: String) -> Self {
		return map { "\($0)\(suffix)" }
	}

	func prefixed(by prefix: String) -> Self {
		return map { "\(prefix)\($0)" }
	}
}

enum ProductType: Equatable {
	case executable
	case library(PackageDescription.Product.Library.LibraryType? = .static)
}

struct ProducibleTarget {
	init(
		target: Target,
		productType: ProductType? = .none
	) {
		self.target = target
		self.productType = productType
	}

	var target: Target
	var productType: ProductType?

	var product: PackageDescription.Product? {
		switch productType {
		case .executable:
			// return .executable(name: target.name, targets: [target.name])
			return nil
		case .library(let type):
			return .library(name: target.name, type: type, targets: [target.name])
		case .none:
			return nil
		}
	}

	static func target(
		name: String,
		product productType: ProductType? = nil,
		dependencies: [Target.Dependency] = [],
		path: CustomTargetPathBuilder? = nil,
		exclude: [String] = [],
		sources: [String]? = nil,
		resources: [Resource]? = nil,
		publicHeadersPath: String? = nil,
		packageAccess: Bool = true,
		cSettings: [CSetting]? = nil,
		cxxSettings: [CXXSetting]? = nil,
		swiftSettings: [SwiftSetting]? = nil,
		linkerSettings: [LinkerSetting]? = nil,
		plugins: [Target.PluginUsage]? = nil
	) -> Self {
		return .init(
			target: productType == .executable
			? .executableTarget(
				name: name,
				dependencies: dependencies,
				path: path?.build(for: name),
				exclude: exclude,
				sources: sources,
				resources: resources,
				publicHeadersPath: publicHeadersPath,
				packageAccess: packageAccess,
				cSettings: cSettings,
				cxxSettings: cxxSettings,
				swiftSettings: swiftSettings,
				linkerSettings: linkerSettings,
				plugins: plugins
			)
			: .target(
				name: name,
				dependencies: dependencies,
				path: path?.build(for: name),
				exclude: exclude,
				sources: sources,
				resources: resources,
				publicHeadersPath: publicHeadersPath,
				packageAccess: packageAccess,
				cSettings: cSettings,
				cxxSettings: cxxSettings,
				swiftSettings: swiftSettings,
				linkerSettings: linkerSettings,
				plugins: plugins
			),
			productType: productType
		)
	}

	static func testTarget(
		name: String,
		dependencies: [Target.Dependency] = [],
		path: CustomTargetPathBuilder? = nil,
		exclude: [String] = [],
		sources: [String]? = nil,
		resources: [Resource]? = nil,
		packageAccess: Bool = true,
		cSettings: [CSetting]? = nil,
		cxxSettings: [CXXSetting]? = nil,
		swiftSettings: [SwiftSetting]? = nil,
		linkerSettings: [LinkerSetting]? = nil,
		plugins: [Target.PluginUsage]? = nil
	) -> Self {
		return .init(
			target: .testTarget(
				name: name,
				dependencies: dependencies,
				path: path?.build(for: name),
				exclude: exclude,
				sources: sources,
				resources: resources,
				packageAccess: packageAccess,
				cSettings: cSettings,
				cxxSettings: cxxSettings,
				swiftSettings: swiftSettings,
				linkerSettings: linkerSettings,
				plugins: plugins
			),
			productType: .none
		)
	}
}

extension Package {
	convenience init(
		name: String,
		defaultLocalization: LanguageTag? = nil,
		platforms: [SupportedPlatform]? = nil,
		pkgConfig: String? = nil,
		providers: [SystemPackageProvider]? = nil,
		dependencies: [Dependency] = [],
		producibleTargets: [ProducibleTarget],
		swiftLanguageModes: [SwiftLanguageMode]? = nil,
		cLanguageStandard: CLanguageStandard? = nil,
		cxxLanguageStandard: CXXLanguageStandard? = nil
	) {
		self.init(
			name: name,
			defaultLocalization: defaultLocalization,
			platforms: platforms,
			pkgConfig: pkgConfig,
			providers: providers,
			products: producibleTargets.compactMap(\.product),
			dependencies: dependencies,
			targets: producibleTargets.map(\.target),
			swiftLanguageModes: swiftLanguageModes,
			cLanguageStandard: cLanguageStandard,
			cxxLanguageStandard: cxxLanguageStandard
		)
	}
}
