//
//  DoctorCrad.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-25.
//

import SwiftUI

struct DoctorCard: View {
    
    @EnvironmentObject var tabManager: TabBarViewModel
    
    let doctor: Doctor
    let onBook: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            
            // MARK: Doctor image
            Image(doctor.image)
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            // MARK: Doctor details
            VStack(alignment: .leading, spacing: 8) {
                
                HStack {
                    Text(doctor.name)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    // Book button
                    Button(action: {
                        tabManager.navigationPath.append(NavigationRoute.doctorDetail(doctor))
                    }) {
                        Text("Book")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 10)
                            .background(
                                Capsule()
                                    .fill(Color(hex: "0930A6"))
                            )
                    }
                }
                
                // MARK: Divider
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 1)
                
                Text("Speciality: \(doctor.speciality)")
                    .font(.system(size: 13))
                    .foregroundColor(.black)
                
                Text("Available: \(doctor.workingTime)")
                    .font(.system(size: 13))
                    .foregroundColor(.black)
                
                HStack {
                    
                    // MARK: Rating
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.yellow)
                        
                        Text(String(format: "%.1f | %d Reviews",
                                    doctor.rating,
                                    doctor.reviewsCount))
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    // MARK: Price (from model)
                    Text(doctor.formattedPrice)
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "0930A6"))
                }
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
        .padding(.horizontal, 10)
    }
}

#Preview {
    VStack(spacing: 16) {
        DoctorCard(
            doctor: Doctor.sampleDoctors[1]
        ) {
            print("Book tapped")
        }
        
//        DoctorCard(
//            doctor: Doctor.sampleDoctors[0]
//        ) {
//            print("Book tapped")
//        }
    }
    .background(Color(hex: "F5F5F5"))
}
