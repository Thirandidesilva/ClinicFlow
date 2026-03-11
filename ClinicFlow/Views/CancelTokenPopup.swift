//
//  CancelTokenPopup.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-28.
//

import SwiftUI

struct CancelTokenPopup: View {
    let onCancel: () -> Void
    let onDismiss: () -> Void
    @State private var showPopup = false
    
    var body: some View {
        ZStack {
            // Dark overlay
            Color.black.opacity(0.6)
                .ignoresSafeArea()
                .onTapGesture {
                    dismissWithAnimation()
                }
            
            // Popup card
            VStack(spacing: 0) {
                Spacer()
                
                VStack(spacing: 20) {
                    // Drag indicator
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 40, height: 5)
                        .padding(.top, 8)
                    
                    // Cancel icon
                    Image("cancel")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(.top, 16)
                    
                    // Title
                    Text("Cancel Token ?")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(hex: "E01F20")) //E01F20
                        .padding(.top, 8)
                    
                    // Description
                    VStack(spacing: 2) {
                        Text("This will permanently remove your slot.")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        
                        Text("Rescheduling may take longer if cancelled.")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                    
                    // Buttons
                    HStack(spacing: 12) {
                        // No, Don't Cancel
                        Button(action: {
                            dismissWithAnimation()
                        }) {
                            Text("No, Don't Cancel")
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
                        
                        // Yes, Cancel
                        Button(action: {
                            dismissWithAnimation()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                onCancel()
                            }
                        }) {
                            Text("Yes, Cancel")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(
                                    RoundedRectangle(cornerRadius: 28)
                                        .fill(Color(hex: "E01F20"))
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
            onDismiss()
        }
    }
}

#Preview {
    CancelTokenPopup(
        onCancel: {
            print("Token cancelled")
        },
        onDismiss: {
            print("Popup dismissed")
        }
    )
}
