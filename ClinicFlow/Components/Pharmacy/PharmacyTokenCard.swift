//
//  PharmacyTokenCard.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-28.
//

import SwiftUI

struct PharmacyTokenCard: View {
    let token: String
    let status: String
    let estimatedTime: String
    let isCompleted: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Your Pharmacy Token")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
            
            // Token Number
            Text(token)
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(Color(hex: "0930A6"))
            
            // Status Capsule
            HStack(spacing: 8) {
                Circle()
                    .fill(statusColor)
                    .frame(width: 8, height: 8)
                
                Text(status)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(statusColor)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(statusColor.opacity(0.06))
                    .overlay(
                        Capsule()
                            .stroke(statusColor, lineWidth: 1)
                    )
            )
            
            // Estimated Ready Time
            if !isCompleted {
                HStack(spacing: 4) {
                    Text("Estimated Ready Time:")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    Text("\(estimatedTime)")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "F5F5F5"))
        )
        .shadow(color: Color(hex: "0930A6").opacity(0.25), radius: 50, x: 1, y: 1)
        .padding(.horizontal, 15)
        .padding(.horizontal, 24)
    }
    
    private var statusColor: Color {
            switch status.lowercased() {
            case "completed":
                return Color.green
            case "preparing", "processing":
                return Color.orange
            case "collecting":
                return Color.blue
            case "almost ready":
                return Color(hex: "FFA500") // Orange
            case "token received":
                return Color.blue
            default:
                return Color.green
            }
        }
}

#Preview {
    VStack(spacing: 20) {
        PharmacyTokenCard(
            token: "P-12",
            status: "Preparing",
            estimatedTime: "1.30 PM",
            isCompleted: false
        )
        
        PharmacyTokenCard(
            token: "P-12",
            status: "Completed",
            estimatedTime: "1.30 PM",
            isCompleted: true
        )
    }
}
