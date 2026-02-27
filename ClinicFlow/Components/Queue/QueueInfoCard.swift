//
//  QueueInfoCard.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-27.
//

import SwiftUI

struct QueueInfoCard: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
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
    HStack(spacing: 16) {
        QueueInfoCard(title: "estimated wait", value: "~15 min")
        QueueInfoCard(title: "ahead of you", value: "01")
    }
    .padding()
    .background(Color.gray.opacity(0.1))
}
