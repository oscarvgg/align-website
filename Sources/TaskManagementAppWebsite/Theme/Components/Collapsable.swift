//
//  File.swift
//  
//
//  Created by Oscar Gonzalez on 26/07/23.
//

import Plot
import Foundation

struct Collapsable: Component {
    
    let title: String
    let content: String
    
    var body: Component {
        Div {
            Input(type: .checkbox)
            Div {
                Text(title)
            }
            .class("collapse-title")
            Div {
                Paragraph(content)
            }
            .class("collapse-content")
        }
        .class("collapse collapse-arrow container mx-auto")
    }
}
