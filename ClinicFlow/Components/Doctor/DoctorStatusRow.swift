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
                icon: "user-group",
                value: "\(patientsCount / 1000)000 +",
                label: "Patients"
            )
            
            Spacer()
            
            // Experience
            StatItem(
                icon: "medal",
                value: "\(experienceYears) +",
                label: "Experience"
            )
            
            Spacer()
            
            // Ratings
            StatItem(
                icon: "customer-review",
                value: "\(ratingsCount)",
                label: "Ratings"
            )
            
            Spacer()
            
            // Reviews
            StatItem(
                icon: "review",
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
        VStack(spacing: 10) {
            
            Image(icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
                .frame(width: 42, height: 42)
                .background(
                    Circle()
                        .fill(Color.gray.opacity(0.09))
                        .padding(-5)
                )
            
            Text(value)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.primary)
            
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.primary)
                .padding(.top,-5)
        }
        .frame(maxWidth: .infinity)
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
