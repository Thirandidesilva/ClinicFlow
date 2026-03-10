//
//  PageIndicatorView.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-02-24.
//

import SwiftUI

struct PageIndicatorView: View {

    let currentIndex: Int   // 0-based
    let totalPages: Int

    private let activeColor  = Color(red: 0.18, green: 0.32, blue: 0.87)
    private let inactiveColor = Color(red: 0.75, green: 0.80, blue: 0.95)

    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<totalPages, id: \.self) { index in
                if index == currentIndex {
                    Capsule()
                        .fill(activeColor)
                        .frame(width: 32, height: 8)
                        .animation(.easeInOut(duration: 0.3), value: currentIndex)
                } else {
                    Circle()
                        .fill(inactiveColor)
                        .frame(width: 8, height: 8)
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: currentIndex)
    }
}

#Preview {
    PageIndicatorView(currentIndex: 0, totalPages: 5)
        .padding()
}
