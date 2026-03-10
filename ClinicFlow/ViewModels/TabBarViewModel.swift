//
//  TabBarViewModel.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-10.
//

import SwiftUI
import Combine

class TabBarViewModel: ObservableObject {
    
    @Published var activeTab: TabModel = .home
    @Published var isTabBarHidden: Bool = false
    @Published var navigationPath = NavigationPath()
    
    var isSecondaryPage: Bool {
        activeTab == .none
    }
    
    func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}
