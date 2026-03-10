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
            HStack(spacing: 0) {
                ForEach(Array(steps.enumerated()), id: \.element.id) { index, step in
                    ZStack {
                        // Line drawn BEHIND the circle
                        if index < steps.count - 1 {
                            HStack {
                                Spacer()
                                Rectangle()
                                    .fill(lineColor(for: step.status))
                                    .frame(height: 2)
                                    .frame(maxWidth: .infinity)
                                    .padding(.bottom, 32)
                            }
                            .offset(x: 33) // push line to start from circle center
                        }
                        
                        VStack(spacing: 8) {
                            ZStack {
                                if step.status == .completed || step.status == .inProgress {
                                    Circle()
                                        .fill(Color(hex: "0930A6").opacity(0.12))
                                        .frame(width: 53, height: 53)
                                }
                                
                                Circle()
                                    .stroke(strokeColor(for: step.status), lineWidth: 2.5)
                                    .frame(width: 44, height: 44)
                                    .background(Circle().fill(fillColor(for: step.status)))
                                
                                Text("\(step.number)")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(textColor(for: step.status))
                            }
                            .frame(width: 53, height: 53)
                            
                            Text(step.title)
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundColor(step.status == .notStarted || step.status == .pending ? Color.gray : Color.black)
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
        .background(Color.white)
        .cornerRadius(16)
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
        PharmacyStep(id: "1", number: 1, title: "Token\nReceived",       status: .completed),
        PharmacyStep(id: "2", number: 2, title: "Got the\nPrescription", status: .completed),
        PharmacyStep(id: "3", number: 3, title: "Preparing\nDrugs",      status: .inProgress),
        PharmacyStep(id: "4", number: 4, title: "Get your\nMedicines",   status: .notStarted)
    ])
    .background(Color.gray.opacity(0.1))
}
