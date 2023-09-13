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
