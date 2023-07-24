import Foundation
import Publish
import Plot
import NPMPublishPlugin

// This type acts as the configuration for your website.
struct TaskManagementAppWebsite: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case blog
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://your-website-url.com")!
    var name = "Task Management AppWebsite"
    var description = "The time blocking app"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
try TaskManagementAppWebsite().publish(withTheme: .myTheme)

//try TaskManagementAppWebsite().publish(using: [
////    .group(plugins.map(PublishingStep.installPlugin)),
//    .step(named: "something", body: { context in
//        let task = Process()
//        let pipe = Pipe()
//
//        task.standardOutput = pipe
//        task.standardError = pipe
//        task.arguments = ["-c", "npx tailwindcss -i ./Sources/Theme/theme.css -o ./Resources/styles.css"]
//        task.executableURL = URL(fileURLWithPath: "/bin/zsh") //<--updated
//        task.standardInput = nil
//
//        try task.run() //<--updated
//
//        let data = pipe.fileHandleForReading.readDataToEndOfFile()
//        let output = String(data: data, encoding: .utf8)!
//
//        print(output)
//    }),
//    .optional(.copyResources()),
//    .addMarkdownFiles(),
//    .sortItems(by: \.date, order: .descending),
//    //                    .group(additionalSteps),
//    .generateHTML(withTheme: .myTheme, indentation: nil),
//    //                    .unwrap(rssFeedConfig) { config in
//    //                        .generateRSSFeed(
//    //                            including: rssFeedSections,
//    //                            config: config
//    //                        )
//    //                    },
////        .generateRSSFeed(
////            including: Set(TaskManagementAppWebsite.SectionID.allCases), // rssFeedSections,
////            config: .default, //config
////        ),
//        .generateRSSFeed(
//            including: Set(TaskManagementAppWebsite.SectionID.allCases),
//            config: .default),
//        .generateSiteMap(indentedBy: nil)
////    .unwrap(deploymentMethod, PublishingStep.deploy)
//])
