//
//  File.swift
//  
//
//  Created by Oscar Gonzalez on 24/07/23.
//

import Plot
import Publish
import Foundation

struct SectionItemGrid<Site>: Component where Site: Website {
    
    private let items: [Item<Site>]
    private let context: PublishingContext<Site>

    init(items: [Item<Site>], context: PublishingContext<Site>) {
        self.items = items
        self.context = context
    }
    
    var body: Component {
        Section {
            Div {
                for item in items {
                    Link(url: "\(item.path.absoluteString)/") {
                        Element(name: "figure") {
                            Image(
                                url: item.imagePath!.string,
                                description: "blog post cover"
                            )
                        }
                        Div {
                            H2(item.title).class("card-title")
                            Paragraph {
                                Text(item.description)
                            }
                            .class("text-sm")
                        }
                        .class("card-body")
                    }
                    .class("card shadow-xl dark:border dark:border-gray-700")
                }
            }
            .class("grid grid-flow-row sm:grid-cols-1 md:grid-cols-2 gap-8 pt-10")
        }
        .class("text-xl max-w-prose mx-auto")
    }
}
