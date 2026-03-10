//
//  UpcomingDrCard.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-24.
//

import SwiftUI

struct UpcomingDrCard: View {
    let date: String
    let time: String
    let doctorImage: String
    let doctorName: String
    let speciality: String
    let rating: Double
    let reviewCount: Int
    let onCheckIn: () -> Void
    @State private var showCheckInPopup = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Date and Check In button
            HStack {
                Text("\(date), \(time)")
                    .font(.system(size: 14, weight: .medium))
                
                Spacer()
                
                
                Button(action: onCheckIn) {
                    Text("Check In")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Capsule().fill(Color(hex: "0930A6")))
                }
            }
            
            // Horizontal divider line
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 1)
                .padding(.horizontal, 0) //line length
            
            // Doctor info
            HStack(spacing: 16) {
                Image(doctorImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 135)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(doctorName)
                        .font(.system(size: 18, weight: .bold))
                    
                    Text("Speciality: \(speciality)")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.yellow)
                        
                        Text(String(format: "%.1f | %d Reviews", rating, reviewCount))
                            .font(.system(size: 14))
                    }
                }
                Spacer()
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.12), radius: 12, x: 0, y: 4)
        )
        .padding(.horizontal, 24)
    }
}

#Preview {
    UpcomingDrCard(
        date: "1st of March 2026",
        time: "1.30 PM",
        doctorImage: "dr.elizabeth",
        doctorName: "Elizabeth Blackwell",
        speciality: "Cardiologist",
        rating: 5.0,
        reviewCount: 156
    ) {
        print("Check In tapped")
    }
    //.background(Color(hex: "F5F5F5"))
}
