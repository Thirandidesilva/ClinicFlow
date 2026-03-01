//
//  MapViewModel.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-03-01
//

import SwiftUI
import Combine

class MapViewModel: ObservableObject {

    // MARK: - Navigation
    @Published var showDirections: Bool = false

    // MARK: - Search
    @Published var searchText: String = ""

    // MARK: - Floor Filter
    @Published var showFloorFilter: Bool = false
    @Published var selectedFloor: FloorLevel = .ground

    // MARK: - Recent Visits
    @Published var recentVisits: [RecentVisit] = [
        RecentVisit(
            imageName: "img_helpdesk",
            name: "Help Desk",
            floor: "GROUND FLOOR",
            speciality: "Cardiologist",
            availableDays: "Mon | Tue | Wed"
        ),
        RecentVisit(
            imageName: "img_lab",
            name: "Laboratory",
            floor: "GROUND FLOOR",
            speciality: "Cardiologist",
            availableDays: "Thu | Fri"
        ),
        RecentVisit(
            imageName: "img_cafeteria",
            name: "Cafeteria",
            floor: "BASEMENT",
            speciality: "Cardiologist",
            availableDays: "Thu | Fri"
        )
    ]

    // MARK: - Floor badge color
    func floorBadgeColor(for floor: String) -> Color {
        switch floor.uppercased() {
        case let f where f.contains("GROUND"): return Color(hex: "1A1AE6")
        case let f where f.contains("FLOOR"):  return Color(hex: "9C27B0")
        case let f where f.contains("BASEMENT"): return Color(hex: "1A1AE6")
        default: return Color(hex: "1A1AE6")
        }
    }

    func selectFloor(_ floor: FloorLevel) {
        selectedFloor = floor
        showFloorFilter = false
    }

    func openDirections() {
        showDirections = true
    }

    func goBack() {
        showDirections = false
        showFloorFilter = false
    }
}
