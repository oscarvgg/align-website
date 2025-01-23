//
//  contactForm.swift
//  AlignWebsite
//
//  Created by Oscar Gonzalez on 29/12/24.
//

import Plot

struct ContactForm: Component {
    let actionEmail = "contact@align.day"

    init() {}

    var body: Component {
        Form(url: "https://formsubmit.co/\(actionEmail)", method: .post) {

            Label("") {
                Div {
                    Span("Your name:")
                        .class("label-text")
                }
                .class("label")

                Input(type: .text, placeholder: "John Doe")
                    .class("input input-bordered w-full max-w-xs")
                    .id("name")
                    .attribute(named: "name", value: "name")
            }
            .class("form-control w-full max-w-xs")

            Label("") {
                Div {
                    Span("Your Email:")
                        .class("label-text")
                }
                .class("label")

                Input(type: .email, placeholder: "john.doe@example.com")
                    .class("input input-bordered w-full max-w-xs")
                    .id("email")
                    .attribute(named: "name", value: "email")
            }
            .class("form-control w-full max-w-xs")

            Label("") {
                Div {
                    Span("Subject:")
                        .class("label-text")
                }
                .class("label")

                Element(name: "select") {
                    Element(name: "option") {
                        Text("Feedback")
                    }
                    .attribute(named: "selected", value: "true")

                    Element(name: "option") {
                        Text("Bug report")
                    }
                }
                .class("select select-bordered")
                .attribute(named: "name", value: "subject")
            }
            .class("form-control w-full max-w-xs")

            Label("") {
                Div {
                    Span("Your message:")
                        .class("label-text")
                }
                .class("label")

                TextArea()
                    .id("message")
                    .class("textarea textarea-bordered h-24")
                    .attribute(
                        named: "placeholder",
                        value: "Enter your feedback or describe the bug you encountered..."
                    )
                    .attribute(named: "required", value: "true")
                    .attribute(named: "name", value: "message")
            }
            .class("form-control")

            Input(
                type: .hidden,
                name: "_subject",
                value: "New Contact Submission from Align.day"
            )

            Input(
                type: .hidden,
                name: "_next",
                value: "https://align.day/help/thank-you/"
            )

            Input(
                type: .hidden,
                name: "_captcha",
                value: "true"
            )

            Div {
                Button("Send")
                    .attribute(named: "type", value: "submit")
                    .class("btn btn-accent btn-block sm:btn-wide")
            }
            .class("text-right mt-4")
        }
    }
}
