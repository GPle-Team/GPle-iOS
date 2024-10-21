@preconcurrency import ProjectDescription

public extension TargetDependency {
    struct SPM {}
}

public extension TargetDependency.SPM {
    static let Moya = TargetDependency.external(name: "Moya")
    static let Firebase = TargetDependency.external(name: "FirebaseAuth")
}

public extension Package {
}
