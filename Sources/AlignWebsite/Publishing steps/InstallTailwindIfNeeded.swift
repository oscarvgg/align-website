//
//  InstallTailwindIfNeeded.swift
//  AlignWebsite
//
//  Created by Oscar Gonzalez on 01/01/25.
//

import Publish
import ShellOut

extension PublishingStep where Site == AlignWebsite {

    static func installTailwindIfNeeded() -> Self {
        .step(named: "Install Tailwind CSS") { _ in
            try shellOut(to: "npm install -D tailwindcss")
        }
    }
}
