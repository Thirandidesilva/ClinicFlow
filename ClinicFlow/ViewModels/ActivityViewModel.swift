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

    // Sheet states
    @Published var showCancelSheet: Bool = false
    @Published var showReviewSheet: Bool = false
    @Published var selectedBookingForCancel: BookingModel? = nil
    @Published var selectedBookingForReview: BookingModel? = nil

    // Review state
    @Published var reviewRating: Int = 4
    @Published var reviewText: String = ""

    // Upcoming is mutable so we can remove items on cancel
    @Published var upcomingBookings: [BookingModel] = [
        BookingModel(
            doctorName: "Dr. David Patel",
            speciality: "Cardiologist",
            date: "March 22, 2026",
            time: "10.15 AM",
            rating: 5,
            reviewCount: 156,
            imageName: "img_Adoc1",
            tab: .upcoming
        )
    ]

    let completedBookings: [BookingModel] = [
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
        )
    ]

    let cancelledBookings: [BookingModel] = [
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

    // MARK: - Actions

    func requestCancel(booking: BookingModel) {
        selectedBookingForCancel = booking
        showCancelSheet = true
    }

    func confirmCancel() {
        if let booking = selectedBookingForCancel {
            upcomingBookings.removeAll { $0.id == booking.id }
        }
        showCancelSheet = false
        selectedBookingForCancel = nil
    }

    func dismissCancel() {
        showCancelSheet = false
        selectedBookingForCancel = nil
    }

    func requestReview(booking: BookingModel) {
        selectedBookingForReview = booking
        reviewRating = 4
        reviewText = ""
        showReviewSheet = true
    }

    func submitReview() {
        showReviewSheet = false
        selectedBookingForReview = nil
        reviewText = ""
        reviewRating = 4
    }
}
