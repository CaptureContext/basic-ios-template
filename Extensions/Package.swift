// swift-tools-version: 5.6

import PackageDescription

// MARK: - Package

let package = Package(
  name: "Extensions",
  platforms: [
    .iOS(.v13)
  ],
  dependencies: [
    .package(
      url: "https://github.com/capturecontext/swift-declarative-configuration.git",
      .upToNextMinor(from: "0.2.0")
    ),
  ],
  producibleTargets: [
    .target(
      name: "LocalExtensions",
      product: .library(.static),
      dependencies: [
        .product(
          name: "DeclarativeConfiguration",
          package: "swift-declarative-configuration"
        ),
      ]
    ),
    .target(
      name: "LocalUIExtensions",
      product: .library(.static),
      dependencies: [
        .target(name: "LocalExtensions")
      ]
    ),
  ]
)

// MARK: - Helpers

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
    path: String? = nil,
    exclude: [String] = [],
    sources: [String]? = nil,
    resources: [Resource]? = nil,
    publicHeadersPath: String? = nil,
    cSettings: [CSetting]? = nil,
    cxxSettings: [CXXSetting]? = nil,
    swiftSettings: [SwiftSetting]? = nil,
    linkerSettings: [LinkerSetting]? = nil
  ) -> ProducibleTarget {
    ProducibleTarget(
      target: productType == .executable
      ? .executableTarget(
        name: name,
        dependencies: dependencies,
        path: path,
        exclude: exclude,
        sources: sources,
        resources: resources,
        publicHeadersPath: publicHeadersPath,
        cSettings: cSettings,
        cxxSettings: cxxSettings,
        swiftSettings: swiftSettings,
        linkerSettings: linkerSettings
      )
      : .target(
        name: name,
        dependencies: dependencies,
        path: path,
        exclude: exclude,
        sources: sources,
        resources: resources,
        publicHeadersPath: publicHeadersPath,
        cSettings: cSettings,
        cxxSettings: cxxSettings,
        swiftSettings: swiftSettings,
        linkerSettings: linkerSettings
      ),
      productType: productType
    )
  }
  
  static func testTarget(
    name: String,
    dependencies: [Target.Dependency] = [],
    path: String? = nil,
    exclude: [String] = [],
    sources: [String]? = nil,
    resources: [Resource]? = nil,
    cSettings: [CSetting]? = nil,
    cxxSettings: [CXXSetting]? = nil,
    swiftSettings: [SwiftSetting]? = nil,
    linkerSettings: [LinkerSetting]? = nil
  ) -> ProducibleTarget {
    ProducibleTarget(
      target: .testTarget(
        name: name,
        dependencies: dependencies,
        path: path,
        exclude: exclude,
        sources: sources,
        resources: resources,
        cSettings: cSettings,
        cxxSettings: cxxSettings,
        swiftSettings: swiftSettings,
        linkerSettings: linkerSettings
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
    swiftLanguageVersions: [SwiftVersion]? = nil,
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
      swiftLanguageVersions: swiftLanguageVersions,
      cLanguageStandard: cLanguageStandard,
      cxxLanguageStandard: cxxLanguageStandard
    )
  }
}
