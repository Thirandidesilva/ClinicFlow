//
//  QueueNumberCircle.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-27.
//


import SwiftUI

struct QueueNumberCircle: View {
    let number: Int
    let status: QueueItem.QueueStatus
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .stroke(strokeColor, lineWidth: 3)
                    .frame(width: 50, height: 50)
                    .background(
                        Circle()
                            .fill(backgroundColor)
                    )
                
                Text("\(number)")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(textColor)
            }
            
            Text(statusText)
                .font(.system(size: 12))
                .foregroundColor(statusTextColor)
        }
    }
    
    // MARK: - Styling
    private var strokeColor: Color {
        switch status {
        case .done:
            return Color(hex: "0930A6")
        case .current:
            return Color.green
        case .next:
            return Color.gray.opacity(0.3)
        case .user:
            return Color.orange
        case .upcoming:
            return Color.gray.opacity(0.3)
        }
    }
    
    private var backgroundColor: Color {
        switch status {
        case .done:
            return Color(hex: "0930A6")
        case .current:
            return Color.green
        case .next:
            return Color.white
        case .user:
            return Color.white
        case .upcoming:
            return Color.white
        }
    }
    
    private var textColor: Color {
        switch status {
        case .done, .current:
            return .white
        case .next:
            return .gray
        case .user:
            return Color.orange
        case .upcoming:
            return Color.gray
        }
    }
    
    private var statusText: String {
        switch status {
        case .done:
            return "Done"
        case .current:
            return "Now"
        case .next:
            return "Next"
        case .user:
            return "You"
        case .upcoming:
            return "Next"
        }
    }
    
    private var statusTextColor: Color {
        switch status {
        case .done:
            return Color(hex: "0930A6")
        case .current:
            return Color.green
        case .next:
            return Color.gray
        case .user:
            return Color.orange
        case .upcoming:
            return Color.gray
        }
    }
}

#Preview {
    HStack(spacing: 16) {
        QueueNumberCircle(number: 21, status: .done)
        QueueNumberCircle(number: 22, status: .done)
        QueueNumberCircle(number: 23, status: .current)
        QueueNumberCircle(number: 24, status: .user)
        QueueNumberCircle(number: 25, status: .next)
    }
}
