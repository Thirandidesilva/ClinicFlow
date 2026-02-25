//
//  Tab.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-23.
//

enum TabModel: String, CaseIterable {
    case home = "home"
    case location = "location"
    case activity = "activity"
    case account = "profile"

    var title: String {
        switch self {
        case .home:     "Home"
        case .location: "Location"
        case .activity: "Activity"
        case .account:  "Profile"
        }
    }

    var icon: String {
        switch self {
        case .home:     "home"
        case .location: "location"
        case .activity: "left alignment"
        case .account:  "profile"
        }
    }
}
