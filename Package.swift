// swift-tools-version:5.7
@preconcurrency import PackageDescription

#if TUIST
@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let packageSetting = PackageSettings(
    baseSettings: .settings(
        configurations: [
            .debug(name: .dev),
            .debug(name: .stage),
            .release(name: .prod)
        ]
    )
)
#endif

let package = Package(
    name: "Package",
    dependencies: []
)
