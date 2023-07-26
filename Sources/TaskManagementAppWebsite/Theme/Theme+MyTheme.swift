//
//  File.swift
//  
//
//  Created by Oscar Gonzalez on 22/07/23.
//

import Foundation
import Publish
import Plot

extension Theme where Site == TaskManagementAppWebsite {
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
            .body(
                .component(NavigationBar(context: context)),
                .mainContentWrapper(
                    .section(
                        .component(WelcomeHero()),
                        .class("pt-16")
                    ),
                    .section(
                        .component(Hero(
                            headingText: "Organize your day",
                            contentText: "Time Block combines your calendars and tasks into a visual timeline")
                        ),
                        .class("pt-16")
                    ),
                    .section(
                        .component(Hero(
                            headingText: "Organize your day",
                            contentText: "Time Block combines your calendars and tasks into a visual timeline",
                            style: .image(imageUrl: "https://placehold.co/480x309"))
                        ),
                        .class("pt-16")
                    ),
                    .section(
                        .component(Hero(
                            headingText: "Organize your day",
                            contentText: "Time Block combines your calendars and tasks into a visual timeline",
                            style: .image(imageUrl: "https://placehold.co/480x309", reversed: true))
                        ),
                        .class("pt-16 pb-16")
                    ),
                    .section(
                        .component(Collapsable(title: "Question 1", content: "Here is your answer")),
                        .component(Collapsable(title: "Question 2", content: "Here is your answer")),
                        .component(Collapsable(title: "Question 3", content: "Here is your answer")),
                        .component(Collapsable(title: "Question 4", content: "Here is your answer")),
                        .component(Collapsable(title: "Question 5", content: "Here is your answer"))
                    )
                ),
                .footer(for: context)
            )
        )
    }

    func makeSectionHTML(for section: Publish.Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body(
                .header(for: context, selectedSection: section.id),
                .mainContentWrapper(
                    .h1(.text(section.title)),
                    .component(SectionItemGrid(
                        items: section.items,
                        context: context)
                    )
                ),
                .footer(for: context)
            )
        )
    }

    func makeItemHTML(for item: Item<Site>,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .class("item-page"),
                .header(for: context, selectedSection: item.sectionID),
                .mainContentWrapper(
                    .article(
                        .class("prose"),
                        .h1(.text(item.title)),
                        .articleMetadataLine(for: item, on: context.site),
                        .div(
                            .class("content"),
                            .contentBody(item.body)
                        )
                    )
                ),
                .footer(for: context)
            )
        )
    }

    func makePageHTML(for page: Page,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .mainContentWrapper(.contentBody(page.body)),
                .footer(for: context)
            )
        )
    }

    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
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
                ),
                .footer(for: context)
            )
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
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
                ),
                .footer(for: context)
            )
        )
    }
}

private extension Node where Context == HTML.BodyContext {
    static func mainContentWrapper(_ nodes: Node...) -> Node {
        .div(.class("container mx-auto"), .group(nodes))
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
    
    static func header<T: Website>(for context: PublishingContext<T>,
                                   selectedSection: T.SectionID?) -> Node {
        let sectionIDs = T.SectionID.allCases
        
        return .header(
            .nav(
                .a(.class("site-name"), .href("/"), .h3(.text(context.site.name))),
                .if(sectionIDs.count > 1,
                    mainNavigation(sectionIDs, selectedSection, context)
                   )
            )
        )
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
        
        return .ul(.class("article-metadata"), .forEach(item.tags) { tag in
            .li(.class("tag"), .a(
                .href(site.path(for: tag)),
                .text(tag.string)
            ))
        },
        .li(
            .text("Published on \(dateFormatter.string(from: item.date))"))
        )
    }

    static func footer<T: Website>(for context: PublishingContext<T>) -> Node {
        return .footer(
            .bottomLists(for: context),
            .div(.class("copyright"),
                 .p(
                    .text("Copyright &#169; Oscar Gonzalez 2021. All rights reserved")
                 ),
                 .p(
                    .text("Generated using "),
                    .a(
                        .text("Publish"),
                        .href("https://github.com/johnsundell/publish")
                    )
                 )
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
