import Foundation

enum AppStoreCampaign: String {
    case webHome = "web_home"
    case webWaitingList = "web_waiting_list"
    case webTimeBlockingPlanner = "web_time_blocking_planner"
    case webTimeBlockingApp = "web_time_blocking_app"
    case webTemplatePost = "web_blog_template_post"
}

enum AppStoreLink {
    static let baseURLString = "https://apps.apple.com/app/align-time-blocking-planner/id6740183716"

    /// Optional App Store Connect Provider Token (for campaign attribution).
    /// Set `APP_STORE_PROVIDER_TOKEN` in the environment when publishing the site.
    static var providerToken: String? {
        ProcessInfo.processInfo.environment["APP_STORE_PROVIDER_TOKEN"]
    }

    static func urlString(campaign: AppStoreCampaign) -> String {
        var components = URLComponents(string: baseURLString)

        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "ct", value: campaign.rawValue),
            URLQueryItem(name: "mt", value: "8")
        ]

        if let providerToken {
            queryItems.append(URLQueryItem(name: "pt", value: providerToken))
        }

        components?.queryItems = queryItems
        return components?.url?.absoluteString ?? baseURLString
    }
}

