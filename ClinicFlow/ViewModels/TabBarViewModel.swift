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
    
    var dismissSecondaryPage: (() -> Void)?
    
    var isSecondaryPage: Bool {
        activeTab == .none
    }
}
