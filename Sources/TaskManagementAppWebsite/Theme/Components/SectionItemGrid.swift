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
        Element(name: "section") {
            for item in items {
                Link(url: item.path.absoluteString) {
                    Element(name: "figure") {
                        Image(
                            url: item.path.string.replacingOccurrences(of: item.sectionID.rawValue, with: ""),
                            description: item.description
                        )
                    }
                    Div {
                        H2(item.title).class("card-title")
                        Paragraph {
                            Text(item.description)
                        }
                    }
                    .class("card-body")
                }
                .class("card bg-base-100 shadow-xl")
            }
        }
        .class("grid grid-flow-row sm:grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8")
    }
}
