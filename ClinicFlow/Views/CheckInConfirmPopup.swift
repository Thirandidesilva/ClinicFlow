//
//  CheckInConfirmPopup.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-04.
//

//
//  CheckInConfirmationPopup.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-04.
//

import SwiftUI

struct CheckInConfirmationPopup: View {
    let date: String
    let time: String
    let doctorName: String
    let roomNumber: String
    let onCheckIn: () -> Void
    let onCancel: () -> Void
    @State private var showPopup = false
    
    var body: some View {
        ZStack {
            // Dark overlay
            Color.black.opacity(0.6)
                .ignoresSafeArea()
                .onTapGesture {
                    dismissWithAnimation()
                }
            
            // Popup card (bottom sheet)
            VStack(spacing: 0) {
                Spacer()
                
                VStack(spacing: 20) {
                    // Drag indicator
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 40, height: 4)
                        .padding(.top, 12)
                    
                    // Green checkmark
//                    ZStack {
//                        Circle()
//                            .stroke(Color(hex: "7CB342"), lineWidth: 6)
//                            .frame(width: 80, height: 80)
//                        
//                        Image(systemName: "checkmark")
//                            .font(.system(size: 40, weight: .bold))
//                            .foregroundColor(Color(hex: "7CB342"))
//                    }
                    Image("confirm")
                    .padding(.top, 8)
                    
                    // Title
                    Text("Ready to Check in ?")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(hex: "7CB342"))
                        .padding(.top, 4)
                    
                    // Description
                    Text("Please make sure you're at or near the clinic before checking in.")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                    
                    // Appointment details card
                    HStack(spacing: 12) {
                        Image(systemName: "calendar")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(date) · \(time)")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.black)
                            
                            Text("\(doctorName) · Room \(roomNumber)")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.1))
                    )
                    .padding(.horizontal, 24)
                    
                    // Buttons
                    HStack(spacing: 12) {
                        // No, not now
                        Button(action: {
                            dismissWithAnimation()
                        }) {
                            Text("No, not now")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(
                                    RoundedRectangle(cornerRadius: 28)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1.5)
                                        .background(
                                            RoundedRectangle(cornerRadius: 28)
                                                .fill(Color.white)
                                        )
                                )
                        }
                        
                        // Yes, Check in
                        Button(action: {
                            dismissWithAnimation()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                onCheckIn()
                            }
                        }) {
                            Text("Yes, Check in")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(
                                    RoundedRectangle(cornerRadius: 28)
                                        .fill(Color(hex: "7CB342"))
                                )
                        }
                    }
                    .padding(.horizontal, 32)
                    .padding(.top, 12)
                    .padding(.bottom, 60)
                }
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.white)
                )
                .offset(y: showPopup ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                showPopup = true
            }
        }
    }
    
    private func dismissWithAnimation() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            showPopup = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            onCancel()
        }
    }
}

#Preview {
    CheckInConfirmationPopup(
        date: "March 1, 2026",
        time: "1:30 PM",
        doctorName: "Dr. Elizabeth Blackwell",
        roomNumber: "F1-307",
        onCheckIn: {
            print("Check in")
        },
        onCancel: {
            print("Cancel")
        }
    )
}
