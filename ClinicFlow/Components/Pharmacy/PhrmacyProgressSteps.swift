//
//  PhrmacyProgressSteps.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-28.
//

import SwiftUI

struct PharmacyProgressSteps: View {
    let steps: [PharmacyStep]
    
    var body: some View {
        HStack(spacing: 0) {
            // Blue vertical bar
//            Rectangle()
//                .fill(Color(hex: "0930A6"))
//                .frame(width: 8)
//                .cornerRadius(8)
            
            // Steps
            HStack(spacing: 0) {
                ForEach(Array(steps.enumerated()), id: \.element.id) { index, step in
                    VStack(spacing: 8) {
                        // Circle
                        ZStack {
                            Circle()
                                .stroke(strokeColor(for: step.status), lineWidth: 2)
                                .frame(width: 50, height: 50)
                                .background(
                                    Circle()
                                        .fill(fillColor(for: step.status))
                                )
                            
                            Text("\(step.number)")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(textColor(for: step.status))
                        }
                        
                        // Title
                        Text(step.title)
                            .font(.system(size: 10))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .frame(width: 60)
                    }
                    
                    // Connecting line
                    if index < steps.count - 1 {
                        Rectangle()
                            .fill(lineColor(for: step.status))
                            .frame(height: 2)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 50)
                    }
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 20)
        }
        .background(Color.white)
        .cornerRadius(16)
//        .overlay(
//            RoundedRectangle(cornerRadius: 16)
//                .stroke(Color(hex: "0930A6"), lineWidth: 1)
//        )
        .padding(.horizontal, 30)
    }
    
    // MARK: - Styling Functions
    private func strokeColor(for status: PharmacyStep.StepStatus) -> Color {
        switch status {
        case .completed:
            return Color(hex: "0930A6")
        case .inProgress:
            return Color(hex: "0930A6")
        case .pending, .notStarted:
            return Color.gray.opacity(0.3)
        }
    }
    
    private func fillColor(for status: PharmacyStep.StepStatus) -> Color {
        switch status {
        case .completed:
            return Color(hex: "0930A6")
        case .inProgress:
            return Color.white
        case .pending, .notStarted:
            return Color.white
        }
    }
    
    private func textColor(for status: PharmacyStep.StepStatus) -> Color {
        switch status {
        case .completed:
            return .white
        case .inProgress:
            return Color(hex: "0930A6")
        case .pending, .notStarted:
            return Color.gray
        }
    }
    
    private func lineColor(for status: PharmacyStep.StepStatus) -> Color {
        switch status {
        case .completed:
            return Color(hex: "0930A6")
        case .inProgress, .pending, .notStarted:
            return Color.gray.opacity(0.3)
        }
    }
}

#Preview {
    PharmacyProgressSteps(steps: [
        PharmacyStep(id: "1", number: 1, title: "Token\nReceived", status: .completed),
        PharmacyStep(id: "2", number: 2, title: "Got the\nPrescription", status: .inProgress),
        PharmacyStep(id: "3", number: 3, title: "Preparing\nDrugs", status: .pending),
        PharmacyStep(id: "4", number: 4, title: "not your\nMedicines", status: .notStarted)
    ])
    .background(Color.gray.opacity(0.1))
}
