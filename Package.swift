// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GPSReader",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "GPSReader",
            targets: ["GPSReader"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "GPSReader",
            dependencies: ["GetExif","GetExifLinux"]),
        .systemLibrary(name: "GetExif", pkgConfig: "libexif",
                       providers: [ .brew(["libexif"])]),
        
        .systemLibrary(name: "GetExifLinux", pkgConfig: "libexif",
        providers: [.apt(["libexif-dev"])]),
        .testTarget(
            name: "GPSReaderTests",
            dependencies: ["GPSReader"]),
    ]
)
