@preconcurrency import ProjectDescription
import EnvironmentPlugin

@MainActor
let workspace = Workspace(
    name: env.name,
    projects: [
        "Projects/App"
    ]
)
