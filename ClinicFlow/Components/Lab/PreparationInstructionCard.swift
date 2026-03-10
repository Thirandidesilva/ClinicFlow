//
//  PreparationInstructionCard.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-01.
//

//
//  PreparationInstructionCard.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-01.
//

import SwiftUI

struct PreparationInstruction: Identifiable {
    let id = UUID()
    let icon: String
    let text: String
}

struct PreparationInstructionCard: View {
    let instructions: [PreparationInstruction]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Title
            Text("Preparation Instruction")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
            
            // Instructions list
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(instructions.enumerated()), id: \.element.id) { index, instruction in
                    HStack(alignment: .top, spacing: 16) {
                        // Icon
                        Image(systemName: instruction.icon)
                            .font(.system(size: 20))
                            .foregroundColor(Color(hex: "0930A6"))
                            .frame(width: 24)
                        
                        // Text
                        Text(instruction.text)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.vertical, 12)
                    
                    // Divider (not for last item)
                    if index < instructions.count - 1 {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 1)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                )
        )
    }
}

#Preview {
    PreparationInstructionCard(instructions: [
        PreparationInstruction(
            icon: "scissors",
            text: "Please fast for 8 hours prior to your test. No food or drinks (except water) after midnight."
        ),
        PreparationInstruction(
            icon: "doc.text",
            text: "Bring any relevant medical reports or referral letters"
        )
    ])
    .padding()
    .background(Color.gray.opacity(0.1))
}
