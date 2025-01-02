//
//  PageContentFactory.swift
//  AlignWebsite
//
//  Created by Oscar Gonzalez on 29/12/24.
//

import Plot
import Publish

final class CustomContentFactory {

    @ComponentBuilder static func makeContent(named: String) -> some Component {
        switch named {
        case "contactForm":
            makeContact()
        default:
            EmptyComponent()
        }
    }

    static func makeContact() -> ContactForm {
        ContactForm()
    }
}
