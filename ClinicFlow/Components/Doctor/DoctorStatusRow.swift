//
//  DoctorStatusRow.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-01.
//

import SwiftUI

struct DoctorStatsRow: View {
    let patientsCount: Int
    let experienceYears: Int
    let ratingsCount: Int
    let reviewsCount: Int
    
    var body: some View {
        HStack(spacing: 0) {
            // Patients
            StatItem(
                icon: "person.3.fill",
                value: "\(patientsCount / 1000)000 +",
                label: "Patients"
            )
            
            Spacer()
            
            // Experience
            StatItem(
                icon: "medal.fill",
                value: "\(experienceYears) +",
                label: "Experience"
            )
            
            Spacer()
            
            // Ratings
            StatItem(
                icon: "person.2.fill",
                value: "\(ratingsCount)",
                label: "Ratings"
            )
            
            Spacer()
            
            // Reviews
            StatItem(
                icon: "message.fill",
                value: "\(reviewsCount)",
                label: "Reviews"
            )
        }
        .padding(.vertical, 20)
    }
}

struct StatItem: View {
    let icon: String
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.black)
            
            Text(value)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
            
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.black)
        }
    }
}

#Preview {
    DoctorStatsRow(
        patientsCount: 3000,
        experienceYears: 10,
        ratingsCount: 5,
        reviewsCount: 1620
    )
    .padding()
}
