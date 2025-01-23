//
//  File.swift
//
//
//  Created by Oscar Gonzalez on 26/07/23.
//

import Foundation
import Plot

struct FooterSection: Component {

    var body: Component {
        Section {
            Div {}.class("bg-base-content/10 my-10 mx-1 h-px")
            Footer {
                Div {
                    Link("Home", url: "/")
                        .class("link link-hover")
                    Link("Blog", url: "/blog/")
                        .class("link link-hover")
                    Link("Help", url: "/help/")
                        .class("link link-hover")
//                    Link("Press Kit", url: "/")
//                        .class("link link-hover")
                    Link("About", url: "/about/")
                        .class("link link-hover")
                    Link("Privacy Policy", url: "/about/privacy-policy/")
                        .class("link link-hover")
                }
                .class("grid grid-flow-col gap-4")
            }
            .class("footer footer-center p-10 text-base-content rounded container mx-auto")
        }
        .class("flex flex-col w-full")
    }
}
