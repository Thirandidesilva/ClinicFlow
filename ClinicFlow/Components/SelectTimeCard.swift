//
//  SelectTimeCard.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-01.
//

//
//  SelectTimeCard.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-01.
//

import SwiftUI

struct SelectTimeCard: View {
    @Binding var selectedTime: String
    let timeSlots = ["Morning", "Afternoon", "Evening"]
    
    var body: some View {
        HStack(spacing: -40) {
            ForEach(timeSlots, id: \.self) { time in
                TimeSlotButton(
                    title: time,
                    isSelected: selectedTime == time
                ) {
                    selectedTime = time
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 4)
        .background(
            Capsule()
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                .padding(.horizontal, )
        )
    }
}

struct TimeSlotButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 0) {
                if isSelected {
//                    Circle()
//                        .fill(Color.white)
//                        .frame(width: 8, height: 8)
                }
                
                Text(title)
                    .font(.system(size: 13, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? .white : .black)
            }
            .padding(.horizontal, isSelected ? 20 : 24)
            .padding(.vertical, 12)
            .frame(minWidth: 0)
            .background(
                Capsule()
                    .fill(isSelected ? Color(hex: "0930A6") : Color.white)
                    .overlay(
                        Capsule()
                            .stroke(Color(hex: "0930A6"), lineWidth: isSelected ? 0 : 1)
                    )
            )
        }
        
        .buttonStyle(.plain)
        .padding(5)
    }
}

#Preview {
    PreviewWrapper()
}

struct PreviewWrapper: View {
    @State private var selectedTime = "Morning"
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 0) {
//                Text("Select Time")
//                    .font(.system(size: 16, weight: .regular))
//                    .padding(.horizontal, 30)
                
                SelectTimeCard(selectedTime: $selectedTime)
                
                    //.padding(.horizontal, 20)
                
//                Text("Selected: \(selectedTime)")
//                    .font(.system(size: 14))
//                    .foregroundColor(.gray)
//                    .padding(.leading, 20)
            }
        }
        .background(Color.white)
    }
}
