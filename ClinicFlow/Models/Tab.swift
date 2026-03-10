//
//  Tab.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-23.
//

import SwiftUI

enum TabModel: String, CaseIterable {
    case home = "home"
    case location = "location"
    case activity = "activity"
    case account = "profile"
    case none = "none"

    var title: String {
        switch self {
        case .home:     "Home"
        case .location: "Location"
        case .activity: "Activity"
        case .account:  "Profile"
        case .none:     ""
        }
    }

    var icon: String {
        switch self {
        case .home:     "home"
        case .location: "location"
        case .activity: "left alignment"
        case .account:  "profile"
        case .none:     ""
        }
    }

    // Only the 4 real tabs — used by CustomTabBar
    static var mainTabs: [TabModel] {
        [.home, .location, .activity, .account]
    }
}
