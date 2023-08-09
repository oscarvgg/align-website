//
//  File.swift
//  
//
//  Created by Oscar Gonzalez on 02/08/23.
//

import Foundation
import Plot

struct LandingPage: Component {
    
    var body: Component {
        ComponentGroup {
            Section {
                WelcomeHero()
            }
            Section {
                Hero(
                    headingText: "Unlock your productivity potential.",
                    contentText: "Align is your personal time management tool helping you revolutionize your daily routine.")
            }
            .class("bg-neutral rounded-lg")
            
            Section {
                Hero(
                    headingText: "Visualize Your Day with Time Blocks",
                    contentText: "Easily plan and organize your day with Align's visual timeline. Each task is represented as a time block, allowing you to see your entire day at a glance. This intuitive interface ensures a clear schedule overview, helping you stay on track and accomplish more.",
                    style: .image(
                        lightImage: Image(
                            url: "/img/day-time-blocks-view-light.webp",
                            description: "timeline view with time blocks"),
                        darkImageUrl: Image(
                            url: "/img/day-time-blocks-view-dark.webp",
                            description: "timeline view with time blocks"))
                    )
            }
            
            Section {
                Hero(
                    headingText: "Customize and Recur Time Blocks",
                    contentText: "With Align, you have complete control over your time blocks. Add tasks to the timeline and customize each with different colors and icons to make them easily distinguishable. You can even make tasks recurrent, saving you time by automatically creating future time blocks. Align adapts to your unique needs, making it effortless to stay organized and focused.",
                    style: .image(
                        lightImage: Image(
                            url: "/img/customize-and-recur-time-blocks-light.webp",
                            description: "time block edit view"),
                        darkImageUrl: Image(
                            url: "/img/customize-and-recur-time-blocks-dark.webp",
                            description: "time block edit view"),
                        reversed: true))
            }.class("bg-neutral rounded-lg")
            
            Section {
                Hero(
                    headingText: "Prioritize and Rearrange Tasks with Ease",
                    contentText: "Align's drag-and-drop functionality lets you rearrange your time blocks effortlessly. Prioritize tasks by moving them up or down, ensuring you allocate time to what matters most. This flexibility empowers you to adapt and adjust your schedule based on your priorities, keeping you productive and proactive throughout the day.",
                    style: .image(
                        lightImage: Image(
                            url: "/img/prioritize-and-rearrange-tasks-with-ease-light.webp",
                            description: "drag and drop time block"),
                        darkImageUrl: Image(
                            url: "/img/prioritize-and-rearrange-tasks-with-ease-dark.webp",
                            description: "drag and drop time block"))
                )
            }
            
            Section {
                Hero(
                    headingText: "Avoid Overlapping Blocks",
                    contentText: "Align's intelligent algorithm automatically checks for overlapping time blocks. Say goodbye to double bookings or conflicting appointments. With Align, you'll have a clear view of your day without any scheduling conflicts, allowing you to maximize your time and focus on what's important.",
                    style: .image(
                        lightImage: Image(
                            url: "/img/avoid-overlapping-blocks-light.webp",
                            description: "timeline view showing an indicator when time blocks overlap"),
                        darkImageUrl: Image(
                            url: "/img/avoid-overlapping-blocks-dark.webp",
                            description: "timeline view showing an indicator when time blocks overlap"),
                        reversed: true)
                )
            }
            .class("bg-neutral rounded-lg")
            
            Section {
                Hero(
                    headingText: "Sync Across All Devices",
                    contentText: "Take advantage of Align's seamless synchronization across all your devices. Whether you're using your iPhone, iPad, or Mac, your tasks and schedule are always up to date. Thanks to the power of iCloud, you can easily access your time blocks wherever you go, ensuring that you stay organized and in control wherever you are.",
                    style: .image(
                        lightImage: Image(
                            url: "/img/sync-across-all-devices-light.png",
                            description: "sync over iphone, ipad and mac"),
                        darkImageUrl: Image(
                            url: "/img/sync-across-all-devices-dark.png",
                            description: "sync over iphone, ipad and mac"))
                )
            }
            
            Section {
                Hero(
                    headingText: "Get Notified When Tasks Start",
                    contentText: "Align helps you stay on top of your schedule with timely notifications. Receive a notification when a task is about to start, so you can transition seamlessly between activities. Say goodbye to missed deadlines or running late. Align keeps you accountable and ensures you stay on track throughout your day.",
                    style: .image(
                        lightImage: Image(
                            url: "/img/get-notified-when-tasks-start-light.webp",
                            description: "Time block edit view showing alert options: when a task starts or some time before"),
                        darkImageUrl: Image(
                            url: "/img/get-notified-when-tasks-start-light.webp",
                            description: "Time block edit view showing alert options: when a task starts or some time before"),
                        reversed: true))
            }
            .class("bg-neutral rounded-lg")
            
            Section {
                Div {
                    Div {
                        Div {
                            H2 {
                                Text("Coming soon")
                            }
                            Paragraph("""
            Align is a powerful tool for staying focused and getting things done. Customize, prioritize, and visualize your tasks at a glance; sync your schedule across all devices, and get timely notifications. With only one in-app purchase, enjoy access to all powerful features without subscription fees.
            Sign up now and be among the first to elevate your time management experience.
            Get ready to align your time and conquer your day.
            """)
                            .class("py-6")
                        }
                        
                        Div {
                            Div {

                            }
                            .style("text-align: left")
                            .class("sender-form-field card-body")
                            .data(named: "sender-form-id", value: "ll1zsrqiezbgrex67to")
                        }
                        .class("card flex-shrink-0")
                    }
                    .class("hero-content flex-col lg:flex-row space-x-4")
                }
                .class("hero md:p-16")
            }
            .class("mt-16")
            
            FooterSection()
        }
    }
}
