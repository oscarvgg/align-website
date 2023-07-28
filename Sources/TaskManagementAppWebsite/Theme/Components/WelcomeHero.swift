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
        Div {
            Div {
                Image(
                    url: "https://placehold.co/260x524",
                    description: "hero image"
                )
                .class("max-w-sm rounded-lg shadow-2xl")
                
                Div {
                    H1 {
                        Text("Time Block")
                    }
                    H2 {
                        Text("the time blocking app")
                    }
                    Paragraph("Split your day into small tasks and get a visual timeline of your day")
                        .class("py-6")
                }
                .class("max-w-md")
            }
            .class("hero-content flex-col lg:flex-row-reverse")
        }
        .class("hero")
    }
}
