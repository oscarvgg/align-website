// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "TaskManagementAppWebsite",
    platforms: [.macOS(.v12)],
    products: [
        .executable(
            name: "TaskManagementAppWebsite",
            targets: ["TaskManagementAppWebsite"]
        )
    ],
    dependencies: [
        .package(name: "Publish",
                 url: "https://github.com/johnsundell/publish.git",
                 from: "0.8.0"),
        .package(name: "NPMPublishPlugin",
                url: "https://github.com/brightdigit/NPMPublishPlugin.git",
                from: "1.0.0"
              )
    ],
    targets: [
        .executableTarget(
            name: "TaskManagementAppWebsite",
            dependencies: ["Publish", "NPMPublishPlugin"]
        )
    ]
)
