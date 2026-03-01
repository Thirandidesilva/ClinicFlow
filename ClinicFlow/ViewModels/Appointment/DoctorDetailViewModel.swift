//
//  DoctorDetailViewModel.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-01.
//

import Foundation
import Combine

class DoctorDetailViewModel: ObservableObject {
    @Published var doctor: Doctor
    @Published var reviews: [Review] = []
    @Published var showAllReviews: Bool = false
    
    init(doctor: Doctor) {
        self.doctor = doctor
        loadReviews()
    }
    
    // MARK: - Load Reviews
    func loadReviews() {
        reviews = Review.sampleReviews
    }
    
    // MARK: - Get Display Reviews
    func getDisplayReviews() -> [Review] {
        return showAllReviews ? reviews : Array(reviews.prefix(2))
    }
    
    // MARK: - Book Appointment
    func bookAppointment() {
        print("Booking appointment with \(doctor.name)")
        // TODO: Navigate to booking confirmation
    }
}

// MARK: - Review Model
struct Review: Identifiable {
    let id: String
    let reviewerName: String
    let reviewerImage: String
    let rating: Double
    let comment: String
    let date: String
}

extension Review {
    static let sampleReviews = [
        Review(
            id: "1",
            reviewerName: "Karan Peak",
            reviewerImage: "user1",
            rating: 5.0,
            comment: "Dr. Blackwell is a knowledgeable and caring cardiologist who explains everything clearly and takes time to listen. Highly recommended.",
            date: "2 days ago"
        ),
        Review(
            id: "2",
            reviewerName: "Karan Peak",
            reviewerImage: "user2",
            rating: 5.0,
            comment: "Dr. Blackwell is one of the best cardiologists in the city. Super friendly and always willing to go the extra mile to help. Highly recommended.",
            date: "1 week ago"
        )
    ]
}
