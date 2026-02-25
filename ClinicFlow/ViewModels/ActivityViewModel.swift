//
//  ActivityViewModel.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-02-25.
//

//
//  ActivityViewModel.swift
//  ClinicFlow
//

import SwiftUI
import Combine

// MARK: - Models

enum BookingTab {
    case upcoming, completed, cancelled
}

struct BookingModel: Identifiable {
    let id = UUID()
    let doctorName: String
    let speciality: String
    let date: String
    let time: String
    let rating: Double
    let reviewCount: Int
    let imageName: String
    let tab: BookingTab
}

// MARK: - ViewModel

class ActivityViewModel: ObservableObject {
    @Published var selectedTab: BookingTab = .upcoming

    let allBookings: [BookingModel] = [
        // Upcoming
        BookingModel(
            doctorName: "Dr. David Patel",
            speciality: "Cardiologist",
            date: "March 22, 2026",
            time: "10.15 AM",
            rating: 5,
            reviewCount: 156,
            imageName: "img_Adoc1",
            tab: .upcoming
        ),
        // Completed
        BookingModel(
            doctorName: "Dr. Sunil Perera",
            speciality: "Neurologist",
            date: "November 12, 2025",
            time: "10.15 AM",
            rating: 5,
            reviewCount: 156,
            imageName: "img_Adoc2",
            tab: .completed
        ),
        BookingModel(
            doctorName: "Dr. David Patel",
            speciality: "Cardiologist",
            date: "July 19, 2025",
            time: "8.15 AM",
            rating: 5,
            reviewCount: 156,
            imageName: "img_Adoc1",
            tab: .completed
        ),
        BookingModel(
            doctorName: "Dr. David Patel",
            speciality: "Cardiologist",
            date: "June 19, 2025",
            time: "10.15 AM",
            rating: 5,
            reviewCount: 156,
            imageName: "img_Adoc1",
            tab: .completed
        ),
        // Cancelled
        BookingModel(
            doctorName: "Dr. Kamal Perera",
            speciality: "Psychiatrists",
            date: "December 19, 2025",
            time: "10.15 AM",
            rating: 5,
            reviewCount: 156,
            imageName: "img_Adoc3",
            tab: .cancelled
        ),
        BookingModel(
            doctorName: "Dr. Hasara Dasanayaka",
            speciality: "Cardiologist",
            date: "May 19, 2025",
            time: "11.15 AM",
            rating: 5,
            reviewCount: 156,
            imageName: "img_Adoc4",
            tab: .cancelled
        )
    ]

    var filteredBookings: [BookingModel] {
        allBookings.filter { $0.tab == selectedTab }
    }
}
