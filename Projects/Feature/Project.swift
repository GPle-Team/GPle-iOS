import DependencyPlugin
@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.Feature.rawValue,
    targets: [
        .implements(module: .feature(.Feature), dependencies: [
            .userInterface(target: .DesignSystem),
            .shared(target: .GlobalThirdPartyLibrary)
        ]),
        .tests(module: .feature(.Feature), dependencies: [
            .feature(target: .Feature)
        ])
    ]
)
