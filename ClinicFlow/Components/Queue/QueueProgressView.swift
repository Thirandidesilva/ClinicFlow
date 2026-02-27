//
//  QueueProgressView.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-27.
//

import SwiftUI

struct QueueProgressView: View {
    let queueItems: [QueueItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header with Live indicator
            HStack {
                Text("Queue Progress")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
                
                // Live indicator
                HStack(spacing: 6) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 5, height: 5)
                        .overlay(
                            Circle()
                                .fill(Color.white.opacity(0.3))
                                .frame(width: 8, height: 8)
                                .scaleEffect(pulseAnimation ? 1.5 : 1.0)
                        )
                    
                    Text("Live")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                
                .background(
                    Capsule()
                        .fill(Color.red)
                )
            }
            .padding(.bottom, 20)
            
            // Queue circles with connecting lines
            HStack(spacing: 0) {
                ForEach(Array(queueItems.enumerated()), id: \.element.id) { index, item in
                    QueueNumberCircle(number: item.number, status: item.status)
                    
                    // Connecting line (except for last item)
                    if index < queueItems.count - 1 {
                        Rectangle()
                            .fill(lineColor(for: item.status))
                            .frame(height: 3)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 30)
                    }
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
        )
        .padding(.horizontal, 15)
        .padding(.vertical,15)
        .onAppear {
            startPulseAnimation()
        }
    }
    
    // MARK: - Line Color Logic
    private func lineColor(for status: QueueItem.QueueStatus) -> Color {
        switch status {
        case .done:
            return Color(hex: "0930A6")
        case .current:
            return Color.green
        case .next, .user, .upcoming:
            return Color.gray.opacity(0.3)
        }
    }
    
    // MARK: - Pulse Animation
    @State private var pulseAnimation = false
    
    private func startPulseAnimation() {
        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
            pulseAnimation = true
        }
    }
}

#Preview {
    QueueProgressView(queueItems: [
        QueueItem(id: "1", number: 21, status: .done),
        QueueItem(id: "2", number: 22, status: .done),
        QueueItem(id: "3", number: 23, status: .current),
        QueueItem(id: "4", number: 24, status: .user),
        QueueItem(id: "5", number: 25, status: .next)
    ])
    .background(Color.gray.opacity(0.1))
}
