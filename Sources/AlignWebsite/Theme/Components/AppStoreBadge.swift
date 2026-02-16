//
//  AppStoreBadge.swift
//  AlignWebsite
//
//  Created by Oscar Gonzalez on 04/02/25.
//

import Foundation
import Plot

struct AppStoreBadge: Component {
    private let campaign: AppStoreCampaign

    init(campaign: AppStoreCampaign = .webHome) {
        self.campaign = campaign
    }

    var body: Component {
        Link(url: AppStoreLink.urlString(campaign: campaign)) {
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
