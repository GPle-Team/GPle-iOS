@preconcurrency import ProjectDescription
import EnvironmentPlugin
import DependencyPlugin

@MainActor
let workspace = Workspace(
    name: env.name,
    projects: [
        "Projects/App",
        "Projects/Domain"
    ]
)
