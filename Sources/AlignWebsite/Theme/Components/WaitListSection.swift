//
//  File.swift
//  
//
//  Created by Oscar Gonzalez on 22/08/23.
//

import Plot
import Publish
import Foundation

struct WaitingListSection: Component {
    
    init() {}
    
    var body: Component {
        Section {
            Div {
                Div {
                  Div {
                    H2 {
                      Text("Download Align for free")
                    }
                    Paragraph("""
Align is a powerful tool for staying focused and getting things done. Customize, prioritize, and visualize your tasks at a glance; sync your schedule across all devices, and get timely notifications.
Get ready to align your time and conquer your day.
""")
                    .class("py-6")
                    
                    Div {
                      
                      Node<Any>.raw(
                           """
                           <a target="_blank" href="https://betalist.com/startups/align-day?utm_campaign=badge-align-day&amp;utm_medium=badge&amp;utm_source=badge-featured">
                           <img alt="Align - Time blocking app that helps you plan, organize, and track your daily tasks | BetaList" height="40" style="height: 40px" src="https://betalist.com/badges/featured?id=117212&amp;theme=color">
                           </a>
                           """
                      )
                      
                      AppStoreBadge()
                    }
                    .class("flex gap-4 justify-left")
                  }
                    
                    Div {
                        Div {}
                            .class("ml-embedded")
                            .data(named: "form", value: "b1TLrP")
                    }
                    .class("card flex-shrink-0")
                }
                .class("hero-content flex-col lg:flex-row space-x-4")
            }
            .class("hero md:p-16")
        }
        .id("waiting-list")
        .class("mt-16")
    }
}
