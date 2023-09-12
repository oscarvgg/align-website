//
//  File.swift
//  
//
//  Created by Oscar Gonzalez on 12/09/23.
//

import Plot
import Foundation

struct AuthorLine: Component {
    
    let author: Author
    let username: Username
    
    internal init(username: Username) {
        self.username = username
        self.author = Author(username: username)
    }
    
    var body: Component {
        Link(url: "/authors/\(author.pageName)/") {
            Div {
                Div {
                    Image("https://www.gravatar.com/avatar/\(author.gravatarHash)?s=40")
                }
                .class("w-12 h-12 rounded-full")
            }
            .class("avatar mr-3")
            
            Div {
                Paragraph("written by \(author.displayName)")
                    .class("text-base-content text-sm")
            }
            .class("text-left")
        }
        .class("inline-flex items-center justify-center")
    }
}
