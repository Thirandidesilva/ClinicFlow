//
//  TopDrCard.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-25.
//

import SwiftUI

struct TopDrCard: View {
    let doctorImage: String
    let doctorName: String
    let onTap: () -> Void
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Doctor image background
            Image(doctorImage)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 220)
                .clipShape(RoundedRectangle(cornerRadius: 24))
            
            // Name card overlay
            HStack {
                Text(doctorName)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.black)
                    .lineLimit(2)
                
                //Spacer()
                
                // Arrow button with gray circle background
                Button(action: onTap) {
                    ZStack {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 28, height: 28)
                        
                        Image(systemName: "arrow.up.right")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
            )
            .padding(16)
        }
        .frame(width: 150, height: 220)
        .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 4)
    }
}

#Preview {
    ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 20) {
            TopDrCard(
                doctorImage: "dr.elizabeth",
                doctorName: "Elizabeth Blackwell"
            ) {
                print("Doctor tapped")
            }
            
            TopDrCard(
                doctorImage: "dr2",
                doctorName: "Jonathan Smith"
            ) {
                print("Doctor tapped")
            }
        }
        .padding(.horizontal, 24)
    }
    .background(Color(hex: "FFFFFF"))
}
