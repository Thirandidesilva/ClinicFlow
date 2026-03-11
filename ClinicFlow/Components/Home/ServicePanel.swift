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
    var onAppointmentTap: () -> Void  // Add this parameter
    var onPharmacyTap: () -> Void
    var onLabTap: () -> Void //onEmergencyLabTap
    var onEmergencyLabTap: () -> Void
    
    var body: some View {
        HStack(spacing: 10) {
            ServiceButton(
                imageName: "appointment",
                title: "Appointment"
            ) {
                onAppointmentTap()  // Call the closure
            }
            
            ServiceButton(
                imageName: "pharmacy",
                title: "Pharmacy"
            ) {
                onPharmacyTap()
            }
            
            ServiceButton(
                imageName: "lab",
                title: "Laboratory"
            ) {
                onLabTap()
            }
            
            ServiceButton(
                imageName: "emergency",
                title: "Emergency Lab"
            ) {
                onEmergencyLabTap()
            }
            .padding(.top, 15)
        }
    }
}

#Preview {
    VStack(spacing: 0) {
        ServiceGrid(
            onAppointmentTap: {
                print("Appointment tapped in preview")
            },
            onPharmacyTap: {
                print("Pharmacy tapped in preview")
            },
            onLabTap: {
                print("Laboratory tapped in preview")
            },
            onEmergencyLabTap: {
                print("Laboratory tapped in preview")
            }
        )
    }
    .background(Color(hex: "FFFFFF"))
}
