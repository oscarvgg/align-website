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
            
            Section {
                Hero(
                    headingText: "Visualize Your Day with Time Blocks",
                    contentText: "Easily plan and organize your day with Align's visual timeline. Each task is represented as a time block, allowing you to see your entire day at a glance. This intuitive interface ensures a clear schedule overview, helping you stay on track and accomplish more.",
                    style: .image(imageUrl: "https://placehold.co/480x309"))
            }
            
            Section {
                Hero(
                    headingText: "Customize and Recur Time Blocks",
                    contentText: "With Align, you have complete control over your time blocks. Add tasks to the timeline and customize each with different colors and icons to make them easily distinguishable. You can even make tasks recurrent, saving you time by automatically creating future time blocks. Align adapts to your unique needs, making it effortless to stay organized and focused.",
                    style: .image(imageUrl: "https://placehold.co/480x309", reversed: true))
            }
            
            Section {
                Hero(
                    headingText: "Prioritize and Rearrange Tasks with Ease",
                    contentText: "Align's drag-and-drop functionality lets you rearrange your time blocks effortlessly. Prioritize tasks by moving them up or down, ensuring you allocate time to what matters most. This flexibility empowers you to adapt and adjust your schedule based on your priorities, keeping you productive and proactive throughout the day.",
                    style: .image(imageUrl: "https://placehold.co/480x309"))
            }
            
            Section {
                Hero(
                    headingText: "Avoid Overlapping Blocks",
                    contentText: "Align's intelligent algorithm automatically checks for overlapping time blocks. Say goodbye to double bookings or conflicting appointments. With Align, you'll have a clear view of your day without any scheduling conflicts, allowing you to maximize your time and focus on what's important.",
                    style: .image(imageUrl: "https://placehold.co/480x309", reversed: true))
            }
            
            Section {
                Hero(
                    headingText: "Sync Across All Devices",
                    contentText: "Take advantage of Align's seamless synchronization across all your devices. Whether you're using your iPhone, iPad, or Mac, your tasks and schedule are always up to date. Thanks to the power of iCloud, you can easily access your time blocks wherever you go, ensuring that you stay organized and in control wherever you are.",
                    style: .image(imageUrl: "https://placehold.co/480x309"))
            }
            
            Section {
                Hero(
                    headingText: "Get Notified When Tasks Start",
                    contentText: "Align helps you stay on top of your schedule with timely notifications. Receive a notification when a task is about to start, so you can transition seamlessly between activities. Say goodbye to missed deadlines or running late. Align keeps you accountable and ensures you stay on track throughout your day.",
                    style: .image(imageUrl: "https://placehold.co/480x309", reversed: true))
            }
            
            Paragraph("""
            Unlock your full productivity potential with Align, the time management app that uses the power of time blocking to revolutionize your daily routine. With features designed to help you visualize, customize, and prioritize your tasks, Align keeps you organized and focused. Seamlessly sync your schedule across all your devices, and receive timely notifications to stay on track.
            No subscriptions are required. Align offers a single in-app purchase, granting you access to all its powerful features without any recurring fees. Sign up to get notified when Align is available in the App Store and be among the first to experience a new level of time management like never before.
            Get ready to align your time and conquer your day.
            """)
            .class("p-16")
            
            FooterSection()
        }
    }
}
