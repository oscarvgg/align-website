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
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://align.day")!
    var name = "Align: The Time Blocking App"
    var description = "Elevate your time management with Align: a visual time blocking app. Plan, prioritize, and stay organized effortlessly. Conquer your day with ease."
    var language: Language { .english }
    var imagePath: Path? { nil }
    
    @discardableResult
    func publish(additionalSteps: [PublishingStep<Self>] = [],
                 plugins: [Plugin<Self>] = [],
                 file: StaticString = #file) throws -> PublishedWebsite<Self> {
        try publish(
            at: nil,
            using: [
                .group(plugins.map(PublishingStep.installPlugin)),
                .optional(.copyResources()),
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
                Self.generateSiteMap(),
                .unwrap(.gitHub(
                    "oscarvgg/align-website",
                    branch: "prod",
                    useSSH: false),
                        PublishingStep.deploy
                )
            ],
            file: file
        )
    }
    
    static func generateSiteMap(excluding excludedPaths: Set<Path> = []) -> PublishingStep<AlignWebsite> {
        PublishingStep.step(named: "Generate site map") { context in
            let generator = AlignSiteMapGenerator(
                excludedPaths: excludedPaths,
                indentation: nil,
                context: context
            )

            try generator.generate()
        }
    }
}

// This will generate your website using the built-in Foundation theme:
try AlignWebsite().publish()

struct AlignSiteMapGenerator<Site: Website> {
    let excludedPaths: Set<Path>
    let indentation: Indentation.Kind?
    let context: PublishingContext<Site>

    func generate() throws {
        let sections = context.sections.sorted {
            $0.id.rawValue < $1.id.rawValue
        }

        let pages = context.pages.values.sorted {
            $0.path < $1.path
        }

        let siteMap = makeSiteMap(for: sections, pages: pages, site: context.site)
        let xml = siteMap.render(indentedBy: indentation)
        let file = try context.createOutputFile(at: "sitemap.xml")
        try file.write(xml)
    }
}

private extension AlignSiteMapGenerator {
    func shouldIncludePath(_ path: Path) -> Bool {
        !excludedPaths.contains(where: {
            path.string.hasPrefix($0.string)
        })
    }

    func makeSiteMap(for sections: [Publish.Section<Site>], pages: [Page], site: Site) -> Plot.SiteMap {
        Plot.SiteMap(
            .forEach(sections) { section in
                guard shouldIncludePath(section.path) else {
                    return .empty
                }

                return .group(
                    .url(
                        .loc("\(site.url(for: section))/"),
                        .changefreq(.daily),
                        .priority(1.0),
                        .lastmod(max(
                            section.lastModified,
                            section.lastItemModificationDate ?? .distantPast
                        ))
                    ),
                    .forEach(section.items) { item in
                        guard shouldIncludePath(item.path) else {
                            return .empty
                        }

                        return .url(
                            .loc("\(site.url(for: item))/"),
                            .changefreq(.monthly),
                            .priority(0.5),
                            .lastmod(item.lastModified)
                        )
                    }
                )
            },
            .forEach(pages) { page in
                guard shouldIncludePath(page.path) else {
                    return .empty
                }

                return .url(
                    .loc("\(site.url(for: page))/"),
                    .changefreq(.monthly),
                    .priority(0.5),
                    .lastmod(page.lastModified)
                )
            }
        )
    }
}
