//
//  VisitJoourney.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-25.
//
//
//  StepIndicator.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-25.
//

import SwiftUI

struct VisitJoourney: View {
    let steps: [String]
    let currentStep: Int
    @State private var activeStep = 0
    
    var body: some View {
        HStack(spacing: 0) {
            // Blue vertical bar on the left
//            Rectangle()
//                .fill(Color(hex: "0930A6"))
//                .frame(width: 8)
            
            // Steps content
            HStack(spacing: 0) {
                ForEach(0..<steps.count, id: \.self) { index in
                    VStack(spacing: 8) {
                        // Circle
                        ZStack {
                            Circle()
                                .stroke(Color(hex: "0930A6"), lineWidth: 2)
                                .frame(width: 40, height: 40)
                            
                            if index <= activeStep {
                                Circle()
                                    .fill(Color(hex: "0930A6"))
                                    .frame(width: 40, height: 40)
                            }
                            
                            Text("\(index + 1)")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(index <= activeStep ? .white : Color(hex: "0930A6"))
                                .scaleEffect(index == activeStep ? 1.1 : 1.0)
                        }
                        
                        // Step label
                        Text(steps[index])
                            .font(.system(size: 12))
                            .fontWeight(index == activeStep ? .semibold : .regular)
                            .foregroundColor(index == activeStep ? Color(hex: "0930A6") : .black)
                            .lineLimit(1)
                            .frame(width: 70)
                    }
                    
                    // Connecting line (except for last step)
                    if index < steps.count - 1 {
                        Rectangle()
                            .fill(Color(hex: "0930A6"))
                            .frame(height: 2)
                            .frame(maxWidth: .infinity)
                            .opacity(index < activeStep ? 1.0 : 0.5)
                            .padding(.bottom, 30)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .frame(height: 100)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(hex: "0930A6"), lineWidth: 1.5)
        )
        .padding(.horizontal, 24)
        .onAppear {
            startIOSAnimation()
        }
    }
    
    func startIOSAnimation() {
        // Slower iOS-style progression
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { timer in  // Changed from 2.0 to 3.0 seconds
            withAnimation(.spring(response: 0.8, dampingFraction: 0.75, blendDuration: 0)) {  // Slower spring response
                activeStep = (activeStep + 1) % steps.count
            }
            
            // Reset when reaching the end
            if activeStep == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {  // Longer pause before reset
                    withAnimation(.spring(response: 0.008, dampingFraction: 0.0075)) {
                        activeStep = 0
                    }
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        VisitJoourney(
            steps: ["Checkin", "Consultation", "Pharmacy", "Lab"],
            currentStep: 1
        )
    }
    .background(Color(hex: "F5F5F5"))
}
