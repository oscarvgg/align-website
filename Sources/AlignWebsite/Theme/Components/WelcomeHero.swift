//
//  File.swift
//
//
//  Created by Oscar Gonzalez on 25/07/23.
//

import Plot
import Foundation

struct WelcomeHero: Component {
    
    var body: Component {
        ComponentGroup {
            Div {
                Div {
                    Div {
                        Image(url: "/img/iphone-screenshot-light.webp",
                              description: "iPhone main screenshot")
                        .class("block dark:hidden")
                        Image(url: "/img/iphone-screenshot-dark.webp",
                              description: "iPhone main screenshot")
                        .class("hidden dark:block")
                    }
                    .class("md:max-w-fit sm:max-w-full h-auto")
                    
                    Div {
                        H1 {
                            Span("Organize Your Day Effectively with: ")
                        }
                        .class("md:text-5xl sm:pt-9")
                        
                        H1 {
                            Span("Align")
                                .class("text-accent")
                        }
                        .class("md:text-9xl pt-8")
                        
                        H2 ("The Time Blocking App")
                            .class("text-4xl font-thin pt-8")
                        
                        Paragraph("Comming soon to the App Store")
                            .class("font-thin pt-3")
                    }
                    .class("max-w-md")
                }
                .class("hero-content mx-auto flex-col lg:flex-row-reverse sm:text-center lg:text-left")
            }
            .class("md:hero sm:px-4 lg:px-16 pb-16")
        }
    }
}
