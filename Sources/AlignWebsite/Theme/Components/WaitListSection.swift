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
                            Text("Coming soon")
                        }
                        Paragraph("""
Align is a powerful tool for staying focused and getting things done. Customize, prioritize, and visualize your tasks at a glance; sync your schedule across all devices, and get timely notifications.
Sign up now and be among the first to elevate your time management experience.
Get ready to align your time and conquer your day.
""")
                        .class("py-6")
                      
                        Node<Any>.raw(
                           """
                           <a target="_blank" href="https://betalist.com/startups/align-day?utm_campaign=badge-align-day&amp;utm_medium=badge&amp;utm_source=badge-featured">
                           <img alt="Align - Time blocking app that helps you plan, organize, and track your daily tasks | BetaList" width="156" height="54" style="width: 156px; height: 54px" src="https://betalist.com/badges/featured?id=117212&amp;theme=color">
                           </a>
                           """
                        )
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
