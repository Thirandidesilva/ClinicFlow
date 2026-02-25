//
//  TabBarNav.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-24.
//

import SwiftUI

struct TabBarNav: View {
    @State private var activeTab: TabModel = .home

    var body: some View {
        if #available(iOS 18, *) {
            TabView(selection: $activeTab) {

                Tab(value: .home) {
                    Text("Home")
                        .toolbarVisibility(.hidden, for: .tabBar)
                }

                Tab(value: .location) {
                    Text("Map")
                        .toolbarVisibility(.hidden, for: .tabBar)
                }

                Tab(value: .activity) {
                    //Text("Activity")
                    ActivityView()
                        .toolbarVisibility(.hidden, for: .tabBar)
                }

                Tab(value: .account) {
                    Text("Account")
                        .toolbarVisibility(.hidden, for: .tabBar)
                }
            }
            .overlay(alignment: .bottom) {
                        CustomTabBar(activeTab: $activeTab)
                            .padding(.bottom, -20)
                            .shadow(color: .black.opacity(0.15), radius: 10)
                    }
        }
    }
}

// MARK: - UIView Extension
extension UIView{ var tabController: UITabBarController? {
    if let controller = sequence(first: self, next: { $0.next })
        .first(where: { $0 is UITabBarController }) as? UITabBarController {
        return controller
    }
    return nil
}}

#Preview {
    TabBarNav()
}
