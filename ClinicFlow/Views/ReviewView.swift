//
//  ReviewView.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-27.
//

import SwiftUI

struct ReviewView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Review")
                    .font(.system(size: 28, weight: .bold))
                
                Text("Please rate your consultation experience")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                // TODO: Add rating stars and feedback form
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Submit Review")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(hex: "0930A6"))
                        )
                }
                .padding(.horizontal, 24)
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ReviewView()
}
