//
//  NotificationButton.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-24.
//

import SwiftUI

struct NotificationButton: View {
    var action: () -> Void = {}
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                
                Button(action: action) {
                    NavigationLink(destination: NotificationView()) {
                    Image(systemName: "bell")
                        .font(.title3)
                        .foregroundColor(.black)
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                        )
                }
            }
                .padding(.trailing, 30)
            }
            .padding(.top, 0)
            
            Spacer()
        }
    }
}

#Preview {
    NotificationButton()
}
