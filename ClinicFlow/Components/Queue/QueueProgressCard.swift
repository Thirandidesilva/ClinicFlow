//
//  QueueProgressCard.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-27.
//

import SwiftUI

struct QueueProgressCard: View {
    let queueItems: [QueueItem]
    let estimatedWait: String
    let aheadOfYou: String
    
    @State private var pulseAnimation = false
    
    var body: some View {
        VStack(spacing: 20) {
            // MARK: - Queue Progress Section
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
            
            // MARK: - Info Cards Section
            HStack(spacing: 16) {
                // Estimated Wait Card
                VStack(spacing: 8) {
                    Text(estimatedWait)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("estimated wait")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
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
                
                // Ahead of You Card
                VStack(spacing: 8) {
                    Text(aheadOfYou)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("ahead of you")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    
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
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
        )
//        .overlay(
//            RoundedRectangle(cornerRadius: 16)
//                .stroke(Color(hex: "0930A6").opacity(0.2), lineWidth: 1)
//        )
        .shadow(color: Color(hex: "0930A6").opacity(0.15), radius: 50, x: 1, y: 1)
        .padding(.horizontal, 15)
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
    private func startPulseAnimation() {
        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
            pulseAnimation = true
        }
    }
}

#Preview {
    QueueProgressCard(
        queueItems: [
            QueueItem(id: "1", number: 21, status: .done),
            QueueItem(id: "2", number: 22, status: .done),
            QueueItem(id: "3", number: 23, status: .current),
            QueueItem(id: "4", number: 24, status: .user),
            QueueItem(id: "5", number: 25, status: .next)
        ],
        estimatedWait: "~15 min",
        aheadOfYou: "01"
    )
    .background(Color.gray.opacity(0.1))
}
