//
//  File.swift
//  
//
//  Created by Oscar Gonzalez on 25/07/23.
//

import Plot
import Foundation

struct Hero: Component {
    
    enum Style {
        case text
        case image(lightImage: Image,
                   darkImageUrl: Image? = nil,
                   reversed: Bool = false)
    }

    init(headingText: String, contentText: String, style: Hero.Style = .text) {
        self.headingText = headingText
        self.contentText = contentText
        self.style = style
    }
    
    private let headingText: String
    private let contentText: String
    private let style: Style
    
    private var flexRowClass: String {
        if case let .image(_, _, reversed) = style, reversed == true {
            return "lg:flex-row-reverse"
        }
        return "lg:flex-row"
    }
    
    private var mainContentClass: String {
        if case .text = style {
            return "text-center"
        }
        return "flex-col \(flexRowClass) space-x-4"
    }
    
    var body: Component {
        Div {
            Div {
                if case let .image(lightImage, darkImage, _) = style {
                    Div {
                        lightImage
                        .class("block dark:hidden md:max-w-sm sm:max-w-full h-auto")
                        
                        if let darkImage {
                            darkImage
                            .class("hidden dark:block md:max-w-sm sm:max-w-full h-auto")
                        }
                    }
                }
                
                Div {
                    H2 {
                        Text(headingText)
                    }
                    
                    Paragraph(contentText)
                        .class("py-6")
                }
            }
            .class("hero-content \(mainContentClass)")
        }
        .class("hero md:p-16")
    }
}
