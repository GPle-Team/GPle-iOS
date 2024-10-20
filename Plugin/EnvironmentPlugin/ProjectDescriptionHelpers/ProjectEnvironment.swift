import Foundation
@preconcurrency import ProjectDescription

public struct ProjectEnvironment {
    public let name: String
    public let organizationName: String
    public let destinations: Destinations
    public let deploymentTargets: DeploymentTargets
    public let baseSetting: SettingsDictionary
}

@MainActor public let env = ProjectEnvironment(
    name: "GPle",
    organizationName: "GSM.GPle",
    destinations: [.iPhone, .iPad],
    deploymentTargets: .iOS("16.0"),
    baseSetting: [:]
)
