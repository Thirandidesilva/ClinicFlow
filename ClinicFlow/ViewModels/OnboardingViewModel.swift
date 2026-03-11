//
//  OnboardingViewModel.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-02-24.
//

import SwiftUI
import Foundation
import Combine

class OnboardingViewModel: ObservableObject {

    // MARK: - Data
    let pages: [InstructionPage] = [
        InstructionPage(id: 1, imageName: "img_insdoc",  title: "Clinic Flow",    subtitle: "Know your place save your time."),
        InstructionPage(id: 2, imageName: "img_insdoc2", title: "Live Queue Tracking",   subtitle: "See your current queue status."),
        InstructionPage(id: 3, imageName: "img_insdoc3", title: "Smart Navigation",   subtitle: "Find your way through the clinic easily."),
        InstructionPage(id: 4, imageName: "img_insdoc4", title: "Notifications",   subtitle: "Receive real-time notifications."),
        InstructionPage(id: 5, imageName: "img_insdoc5", title: "Lab & Pharmacy",   subtitle: "Track lab and pharmacy services in real time")
    ]

    // MARK: - Published
    @Published var currentIndex: Int = 0
    @Published var navigateToSetup: Bool = false

    // MARK: - Computed
    var currentPage: InstructionPage {
        pages[currentIndex]
    }

    var totalPages: Int {
        pages.count
    }

    var isLastPage: Bool {
        currentIndex == totalPages - 1
    }

    // MARK: - Actions

    func goToNext() {
        if isLastPage {
            navigateToSetup = true
        } else {
            withAnimation(.easeInOut(duration: 0.3)) {
                currentIndex += 1
            }
        }
    }

    func skip() {
        navigateToSetup = true
    }
}
