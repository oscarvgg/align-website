//
//  AppStoreBadge.swift
//  AlignWebsite
//
//  Created by Oscar Gonzalez on 04/02/25.
//

import Foundation
import Plot

struct AppStoreBadge: Component {

    var body: Component {
        Link(url: "https://apps.apple.com/app/align-time-blocking-planner/id6740183716") {
            Div {
                Image(
                    url: "/img/download-on-the-app-store-badge-black.svg",
                    description: "Download on the App Store badge"
                )
                .class("block dark:hidden")

                Image(
                    url: "/img/download-on-the-app-store-badge-white.svg",
                    description: "Download on the App Store badge"
                )
                .class("hidden dark:block")
            }
            .class("text-left")
        }
    }
}
