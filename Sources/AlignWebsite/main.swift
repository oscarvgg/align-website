import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct AlignWebsite: Website {
    enum SectionID: String, WebsiteSectionID {
      // Add the sections that you want your website to contain here:
      case blog
    }

    struct ItemMetadata: WebsiteItemMetadata {
        var author: Username?
        var customContent: String?
        var hidePublishedDate: Bool?
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://align.day")!
    var name = "Align: The Time Blocking App"
    var description = "Elevate your time management with Align: a visual time blocking app. Plan, prioritize, and stay organized effortlessly. Conquer your day with ease."
    var language: Language { .english }
    var imagePath: Path? { nil }
    var favicon: Favicon? {
        return Favicon(path: "favicon.png", type: "image/x-icon")
    }
    
    @discardableResult
    func publish(additionalSteps: [PublishingStep<Self>] = [],
                 plugins: [Plugin<Self>] = [],
                 file: StaticString = #file) throws -> PublishedWebsite<Self> {
        try publish(
            at: nil,
            using: [
                .group(plugins.map(PublishingStep.installPlugin)),
//                .optional(.copyResources()),
                .generateTailwindCSS,
                .copyResourcesWithShell,
                .addMarkdownFiles(),
                .sortItems(by: \.date, order: .descending),
                .group(additionalSteps),
                .generateHTML(withTheme: .myTheme, indentation: nil),
                .move404FileForGitHubPages(),
                .unwrap(.default) { config in
                    .generateRSSFeed(
                        including: Set(SectionID.allCases),
                        config: config
                    )
                },
                .generateSiteMap(excluding: [Path("404")]),
//                .installTailwindIfNeeded(),
                .unwrap(.gitHub(
                    "oscarvgg/align-website",
                    branch: "prod",
                    useSSH: true),
                        PublishingStep.deploy
                )
            ],
            file: file
        )
    }
}

// This will generate your website using the built-in Foundation theme:
try AlignWebsite().publish()
