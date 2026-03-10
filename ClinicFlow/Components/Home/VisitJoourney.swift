//
//  VisitJoourney.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-25.
//

import SwiftUI

struct VisitJourney: View {
    let steps: [String]
    let currentStep: Int
    @State private var activeStep = 0
    
    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(Array(steps.enumerated()), id: \.element) { index, step in
                    ZStack {
                        // Line drawn BEHIND the circle
                        if index < steps.count - 1 {
                            HStack {
                                Spacer()
                                Rectangle()
                                    .fill(lineColor(for: index))
                                    .frame(height: 2)
                                    .frame(maxWidth: .infinity)
                                    .padding(.bottom, 22)
                            }
                            .offset(x: 33)
                        }
                        
                        VStack(spacing: 8) {
                            ZStack {
                                // Outer glow circle (only for completed/active)
                                if index <= activeStep {
                                    Circle()
                                        .fill(Color(hex: "0930A6").opacity(0.12))
                                        .frame(width: 53, height: 53)
                                }
                                
                                // Main circle
                                Circle()
                                    .stroke(strokeColor(for: index), lineWidth: 2.5)
                                    .frame(width: 44, height: 44)
                                    .background(Circle().fill(fillColor(for: index)))
                                
                                // Number
                                Text("\(index + 1)")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(textColor(for: index))
                            }
                            .frame(width: 53, height: 53)
                            
                            // Step label
                            Text(step)
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundColor(index <= activeStep ? Color.black : Color.gray)
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(width: 72)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 4)
            .padding(.vertical, 20)
        }
        .frame(height: 100)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(hex: "0930A6").opacity(0.5), lineWidth: 1.5)
        )
        .padding(.horizontal, 24)
        .onAppear {
            startIOSAnimation()
        }
    }
    
    // MARK: - Styling Functions
    
    private func strokeColor(for index: Int) -> Color {
        if index < activeStep {
            return Color(hex: "0930A6") // Completed
        } else if index == activeStep {
            return Color(hex: "0930A6") // In progress
        } else {
            return Color.gray.opacity(0.3) // Not started
        }
    }
    
    private func fillColor(for index: Int) -> Color {
        if index < activeStep {
            return Color(hex: "0930A6") // Completed - filled
        } else {
            return Color.white // Not completed - white
        }
    }
    
    private func textColor(for index: Int) -> Color {
        if index < activeStep {
            return .white // Completed - white text
        } else if index == activeStep {
            return Color(hex: "0930A6") // In progress - blue text
        } else {
            return Color.gray // Not started - gray text
        }
    }
    
    private func lineColor(for index: Int) -> Color {
        if index < activeStep {
            return Color(hex: "0930A6") // Completed line - blue
        } else {
            return Color.gray.opacity(0.3) // Not completed - gray
        }
    }
    
    // MARK: - Animation
    
    func startIOSAnimation() {
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { timer in
            withAnimation(.spring(response: 0.8, dampingFraction: 0.75, blendDuration: 0)) {
                activeStep = (activeStep + 1) % steps.count
            }
            
            if activeStep == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.75)) {
                        activeStep = 0
                    }
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        VisitJourney(
            steps: ["Checkin", "Consultation", "Pharmacy", "Lab"],
            currentStep: 1
        )
    }
    .background(Color(hex: "F5F5F5"))
}
