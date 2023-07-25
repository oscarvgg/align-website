//
//  File.swift
//  
//
//  Created by Oscar Gonzalez on 24/07/23.
//

import Plot
import Publish
import Foundation

struct NavigationBar<T>: Component where T: Website {
    
    private let selectedSection: T.SectionID?
    private let context: PublishingContext<T>

    init(selectedSection: T.SectionID? = nil, context: PublishingContext<T>) {
        self.selectedSection = selectedSection
        self.context = context
    }
    
    var body: Component {
        
        Div {
            Div {
                Link(url: "/") {
                    Image(url: "/", description: "app logo")
                }
                .class("btn btn-ghost normal-case text-xl")
            }
            .class("flex-1")
            
            Navigation {
                List(T.SectionID.allCases) { section in
                    ListItem {
                        Link(url: context.sections[section].path.string) {
                            Text(context.sections[section].title)
                        }
                    }
                    .class(section == selectedSection ? "selected" : "")
                }
                .class("menu menu-horizontal px-1")
            }
            .class("flex-none")
        }
        .class("navbar bg-base-100")
    }
}
