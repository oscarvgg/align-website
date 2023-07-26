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
                    Link("Blog", url: "/")
                        .class("link link-hover")
                    Link("Help", url: "/")
                        .class("link link-hover")
                    Link("Press Kit", url: "/")
                        .class("link link-hover")
                    Link("Privacy Policy", url: "/")
                        .class("link link-hover")
                }
                .class("grid grid-flow-col gap-4")
            }
            .class("footer footer-center p-10 text-base-content rounded")
        }
        .class("flex flex-col w-full")
    }
}
