//
//  GenerateTailwindCss.swift
//  AlignWebsite
//
//  Created by Oscar Gonzalez on 01/01/25.
//

import Publish
import ShellOut

extension PublishingStep where Site == AlignWebsite {
    static func generateTailwindCSS(input: String, output: String) -> Self {
        .step(named: "Generate Tailwind CSS") { _ in
            let command = "/usr/local/bin/npx tailwindcss -i \(input) -o \(output)"
            do {
                try shellOut(to: command)
            }
            catch {
                throw PublishingError(
                    stepName: "Generate Tailwind CSS", infoMessage: "error generating Tailwind CSS",
                    underlyingError: error)
            }
        }
    }
}
