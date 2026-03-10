//
//  ApointmentConfirmedPopup.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-04.
//

import SwiftUI

struct AppointmentConfirmedPopup: View {
    let appointmentNumber: String
    let date: String
    let time: String
    let doctorName: String
    let roomNumber: String
    let onDone: () -> Void
    
    var body: some View {
        ZStack {
            // Background overlay
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            // Popup card
            VStack(spacing: 24) {
                // Green checkmark
                
                Image("confirm")
                //Image(systemName: "checkmark.circle.fill")
                    //.font(.system(size: 80))
                    //.foregroundColor(Color(hex: "4CAF50"))
                
                Text("Appointment Confirmed!")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                
                // Appointment details
                HStack(spacing: 10) {
                    Image(systemName: "calendar")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .padding(.bottom, 30)
                        .padding(.leading, 20)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Appointment No: \(appointmentNumber)")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.black)
                        
                        Text("\(date) · \(time)")
                            .font(.system(size: 13))
                            .foregroundColor(.black)
                        
                        Text("\(doctorName) · Room \(roomNumber)")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.05))
                )
                
                // Done button
                Button(action: onDone) {
                    Text("Done")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(hex: "0930A6"))
                        )
                }
                .padding(.horizontal, 50)
                .padding(.vertical, 20)
                
            }
            .padding(20)
            //.padding()
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
            )
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    AppointmentConfirmedPopup(
        appointmentNumber: "#25",
        date: "March 1, 2026",
        time: "1:30 PM",
        doctorName: "Dr. Elizabeth Blackwell",
        roomNumber: "F1-307",
        onDone: {}
    )
}
