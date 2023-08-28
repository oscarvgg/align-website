//
//  File.swift
//  
//
//  Created by Oscar Gonzalez on 22/07/23.
//

import Foundation
import Publish
import Plot

extension Theme where Site == AlignWebsite {
    static var myTheme: Self {
        Theme(
            htmlFactory: MyThemeHTMLFactory()
        )
    }
}

private struct MyThemeHTMLFactory<Site: Website>: HTMLFactory {
    
    func makeIndexHTML(for index: Index,
                       context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .googleTrackerHead(),
            .senderHead(),
            .body(
                .component(NavigationBar(context: context)),
                .mainContentWrapper(
                    .component(LandingPage())
                )
            )
        )
    }

    func makeSectionHTML(for section: Publish.Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .googleTrackerHead(),
            .senderHead(),
            .body(
                .component(NavigationBar(selectedSection: section.id, context: context)),
                .mainContentWrapper(
                    .section(
                        .class("prose md:prose-xl mx-auto"),
                        .contentBody(section.body)
                    ),
                    .component(SectionItemGrid(
                        items: section.items,
                        context: context)
                    )
                ),
                .component(FooterSection())
            )
        )
    }

    func makeItemHTML(for item: Item<Site>,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .googleTrackerHead(),
            .senderHead(),
            .body(
                .class("item-page"),
                .component(NavigationBar(selectedSection: item.sectionID, context: context)),
                .mainContentWrapper(
                    .article(
                        .unwrap(item.imagePath, { imagePath in
                                .div(
                                    .class("prose md:prose-xl mx-auto mb-10"),
                                    .img(.src(item.imagePath!), .alt("blog post cover"))
                                )
                        }),
                        .div(
                            .class("prose md:prose-xl mx-auto"),
                            .h1(.text(item.title))
                        ),
                        .div(
                            .class("text-xl max-w-prose mx-auto"),
                            .articleMetadataLine(for: item, on: context.site)
                        ),
                        .div(
                            .class("prose md:prose-xl mx-auto"),
                            .contentBody(item.body)
                        )
                    )
                ),
                .component(WaitingListSection()),
                .component(FooterSection())
            )
        )
    }

    func makePageHTML(for page: Page,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .googleTrackerHead(),
            .senderHead(),
            .body(
                .component(NavigationBar(context: context)),
                .mainContentWrapper(.contentBody(page.body)),
                .component(FooterSection())
            )
        )
    }

    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .title("All Tags"),
            .head(for: page, on: context.site, rssFeedPath: .defaultForTagHTML, rssFeedTitle: "Tags"),
            .googleTrackerHead(),
            .senderHead(),
            .body(
                .component(NavigationBar(context: context)),
                .mainContentWrapper(
                    .h1("Browse all tags"),
                    .ul(
                        .class("all-tags"),
                        .forEach(page.tags.sorted()) { tag in
                            .li(
                                .class("tag"),
                                .a(
                                    .href(context.site.path(for: tag)),
                                    .text(tag.string)
                                )
                            )
                        }
                    )
                )
            )
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .googleTrackerHead(),
            .senderHead(),
            .body(
                .component(NavigationBar(context: context)),
                .mainContentWrapper(
                    .h1(
                        "Tagged with ",
                        .span(.class("tag"), .text(page.tag.string))
                    ),
                    .a(
                        .class("browse-all"),
                        .text("Browse all tags"),
                        .href(context.site.tagListPath)
                    ),
                    .itemList(
                        for: context.items(
                            taggedWith: page.tag,
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site
                    )
                )
            )
        )
    }
}

private extension Node where Context == HTML.BodyContext {
    static func mainContentWrapper(_ nodes: Node...) -> Node {
        .div(.class("md:container mx-auto pt-10 px-4"), .group(nodes))
    }

    static func mainNavigation<T: Website>(
        _ sectionIDs: T.SectionID.AllCases,
        _ selectedSection: T.SectionID?,
        _ context: PublishingContext<T>) -> Node<HTML.BodyContext> {
        return .nav(
            .ul(.forEach(sectionIDs) { section in
                .li(.a(
                    .class(section == selectedSection ? "selected" : ""),
                    .href(context.sections[section].path),
                    .text(context.sections[section].title)
                ))
            }
            ))
    }

    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
        return .ul(
            .class("item-list"),
            .forEach(items) { item in
                .li(.article(
                    .h2(.a(
                        .href(item.path),
                        .text(item.title)
                    )),
                    .tagList(for: item, on: site),
                    .p(.text(item.description))
                ))
            }
        )
    }

    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .ul(.class("tag-list"), .forEach(item.tags) { tag in
            .li(.a(
                .href(site.path(for: tag)),
                .text(tag.string)
            ))
        })
    }
    
    static func articleMetadataLine<T: Website>(for item: Item<T>, on site: T) -> Node {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        return
            .div(
                .class("mb-10"),
                .div(
                    .class("my-2"),
                    .text("Published on \(dateFormatter.string(from: item.date))")
                ),
                .ul(
                    .class("flex flex-row my-2 items-center justify-items-start list-none p-0 m-0 pl-0 mt-0"),
                    .forEach(item.tags) { tag in
                            .li(
                                .class("text-sm p-2 font-medium rounded bg-accent items-center justify-center"),
                                .a(.href(site.path(for: tag)), .text(tag.string), .class("text-white no-underline"))
                            )
                    }
                )
            )
    }
    
    static func bottomLists<T: Website>(for context: PublishingContext<T>) -> Node {
        let allTags = context
            .allTags
            .sorted { (tag1, tag2) -> Bool in
                return tag1.string < tag2.string
            }
        
        return .div(
            .class("bottom-lists"),
            .div(.class("site-name"),
                 .h2(.text("OscarVGG")),
                 .p(.text(context.site.description))
            ),
            .div(.class("links"),
                .div(.class("link-list"),
                     .h3(.text("Tags")),
                     .ul(.forEach(allTags) { tag in
                        .li(.a(
                            .href(context.site.path(for: tag)),
                            .text(tag.string)
                        ))
                    })
                ),
                .div(.class("link-list"),
                     .h3(.text("Follow")),
                     .ul(
                        .li(.a(
                            .href("https://twitter.com/oscarvgg"),
                            .text("Twitter")
                        )),
                        .li(.a(
                            .href("https://www.linkedin.com/in/oscarvgg"),
                            .text("LinkedIn")
                        )),
                        .li(.a(
                            .href("/feed.rss"),
                            .text("RSS")
                        ))
                    )
                ),
                .div(.class("link-list"),
                     .h3(.text("Info")),
                     .ul(
                        .li(.a(
                            .href("/about"),
                            .text("About")
                        )),
                        .li(.a(
                            .href("mailto:contact@oscarvgg.com"),
                            .text("Email")
                        ))
                    )
                )
            )
        )
    }
}

public extension Node where Context == HTML.DocumentContext {
    
    static func googleTrackerHead() -> Node {
        .head(
            .script(.src("https://www.googletagmanager.com/gtag/js?id=G-T0WWL4KDTV")),
            .script(
    """
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());
    
        gtag('config', 'G-T0WWL4KDTV');
    """
            ))
    }
    
    static func senderHead() -> Node {
        .head(
        .script(
        """
            (function (s, e, n, d, er) {
                s['Sender'] = er;
                s[er] = s[er] || function () {
                  (s[er].q = s[er].q || []).push(arguments)
                }, s[er].l = 1 * new Date();
                var a = e.createElement(n),
                    m = e.getElementsByTagName(n)[0];
                a.async = 1;
                a.src = d;
                m.parentNode.insertBefore(a, m)
              })(window, document, 'script', 'https://cdn.sender.net/accounts_resources/universal.js', 'sender');
              sender('20f1418bde9678')
        """
        ))
    }
    
    /// Add an HTML `<head>` tag within the current context, based
    /// on inferred information from the current location and `Website`
    /// implementation.
    /// - parameter location: The location to generate a `<head>` tag for.
    /// - parameter site: The website on which the location is located.
    /// - parameter titleSeparator: Any string to use to separate the location's
    ///   title from the name of the website. Default: `" | "`.
    /// - parameter stylesheetPaths: The paths to any stylesheets to add to
    ///   the resulting HTML page. Default: `styles.css`.
    /// - parameter rssFeedPath: The path to any RSS feed to associate with the
    ///   resulting HTML page. Default: `feed.rss`.
    /// - parameter rssFeedTitle: An optional title for the page's RSS feed.
    static func head<T: Website>(
        for location: Location,
        on site: T,
        titleSeparator: String = " | ",
        stylesheetPaths: [Path] = ["/styles.css"],
        rssFeedPath: Path? = .defaultForRSSFeed,
        rssFeedTitle: String? = nil
    ) -> Node {
        var title = location.title

        if location is TagListPage {
            title = "Tags "
            title.append(titleSeparator + site.name)
        } else if let tagPage = location as? TagDetailsPage {
            title = "\(tagPage.tag.string.capitalized) "
            title.append(titleSeparator + site.name)
        } else if title.isEmpty {
                title = site.name
        } else {
            title.append(titleSeparator + site.name)
        }

        var description = location.description

        if description.isEmpty {
            description = site.description
        }

        return .head(
            .encoding(.utf8),
            .siteName(site.name),
            .url(site.url(for: location)),
            .title(title),
            .description(description),
            .twitterCardType(location.imagePath == nil ? .summary : .summaryLargeImage),
            .forEach(stylesheetPaths, { .stylesheet($0) }),
            .viewport(.accordingToDevice),
            .unwrap(site.favicon, { .favicon($0) }),
            .unwrap(rssFeedPath, { path in
                let title = rssFeedTitle ?? "Subscribe to \(site.name)"
                return .rssFeedLink(path.absoluteString, title: title)
            }),
            .unwrap(location.imagePath ?? site.imagePath, { path in
                let url = site.url(for: path)
                return .socialImageLink(url)
            })
        )
    }
}

public extension Node where Context == HTML.HeadContext {
    /// Declare the HTML page's canonical URL, for social sharing and SEO.
    /// - parameter url: The URL to declare as this document's canonical URL.
    static func url(_ url: URLRepresentable) -> Node {
        let url = url.description
        
        return .group([
            .link(.rel(.canonical), .href("\(url)/")),
            .meta(.name("twitter:url"), .content("\(url)/")),
            .meta(.property("og:url"), .content("\(url)/"))
        ])
    }
}
