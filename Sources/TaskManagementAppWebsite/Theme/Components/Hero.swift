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
        case image(imageUrl: URLRepresentable, reversed: Bool = false)
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
        if case let .image(_, reversed) = style, reversed == true {
            return "lg:flex-row-reverse"
        }
        return "lg:flex-row"
    }
    
    private var textContentClass: String {
        if case .text = style {
            return "" // "max-w-md"
        }
        return ""
    }
    
    private var mainContentClass: String {
        if case .text = style {
            return "text-center"
        }
        return "flex-col \(flexRowClass)"
    }
    
    var body: Component {
        Div {
            Div {
                if case let .image(imageUrl, _) = style {
                    Image(
                        url: imageUrl,
                        description: "hero image"
                    )
                    .class("max-w-sm rounded-lg")
                }
                
                Div {
                    H2 {
                        Text(headingText)
                    }
                    
                    Paragraph(contentText)
                        .class("py-6")
                }
                .class(textContentClass)
            }
            .class("hero-content \(mainContentClass)")
        }
        .class("hero bg-base-200")
    }
}
