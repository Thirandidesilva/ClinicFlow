//
//  Landingviewmodel.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-02-24.
//

import Foundation
import Combine

class Landingviewmodel: ObservableObject {
    
    @Published var isNavigating: Bool = false
    
    func getStartedTapped() {
        isNavigating = true
    }
}
