//
//  ServicePanel.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-24.
//

import SwiftUI

struct ServiceButton: View {
    let imageName: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                // Icon container
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .frame(width: 70, height: 70)
                        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
                    
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
                
                // Title
                Text(title)
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(width: 80)
        }
        .buttonStyle(.plain)
    }
}

struct ServiceGrid: View {
    var body: some View {
        HStack(spacing: 10) {
            ServiceButton(
                imageName: "appointment",
                title: "Appointment"
            ) {
                print("Appointment tapped")
            }
            
            ServiceButton(
                imageName: "pharmacy",
                title: "Pharmacy"
            ) {
                print("Pharmacy tapped")
            }
            
            ServiceButton(
                imageName: "lab",
                title: "Laboratory"
            ) {
                print("Laboratory tapped")
            }
            
            ServiceButton(
                imageName: "emergency",
                title: "Emergency Lab"
            ) {
                print("Emergency Lab tapped")
            }
            .padding(.top, 15)
        }
        //.padding(.horizontal, 24)
    }
}

#Preview {
    VStack(spacing: 0) {
        // Preview full grid
        ServiceGrid()
    }
    .background(Color(hex: "FFFFFF"))
}
