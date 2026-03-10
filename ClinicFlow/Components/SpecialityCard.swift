//
//  SpecialtyCard.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-25.
//

import SwiftUI

// MARK: - SpecialtyCard (with image for dashboard)
struct SpecialtyCard: View {
    let specialty: Specialty
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 8) {
                // Image container with unique color
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(hex: specialty.backgroundColor))
                        .frame(width: 100, height: 100)
                        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
                    
                    Image(specialty.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .padding(.bottom, 20)
                    
                    // Specialty name
                    Text(specialty.name)
                        .font(.system(size: 11, weight: isSelected ? .semibold : .medium))
                        .foregroundColor(isSelected ? Color(hex: "0930A6") : .black)
                        .lineLimit(1)
                        .frame(width: 100)
                        .padding(.top, 60)
                }
                Spacer()
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - SpecialtyChip
struct SpecialtyChip: View {
    let specialty: Specialty
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Text(specialty.name)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(isSelected ? .white : .black)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(
                    Capsule()
                        .fill(isSelected ? Color(hex: "0930A6") : Color.white)
                )
                .overlay(
                    Capsule()
                        .strokeBorder(Color(hex: "0930A6"), lineWidth: isSelected ? 0 : 1)
                )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Previews
#Preview("Cards with Images - All Specialties") {
    ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 16) {
            ForEach(Specialty.allSpecialties) { specialty in
                SpecialtyCard(
                    specialty: specialty,
                    isSelected: specialty.id == "1"
                ) {
                    print("\(specialty.name) tapped")
                }
            }
        }
        .padding(.horizontal, 24)
    }
    .background(Color.gray.opacity(0.1))
}

#Preview("Text Chips - All Specialties") {
    ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 12) {
            ForEach(Specialty.allSpecialties) { specialty in
                SpecialtyChip(
                    specialty: specialty,
                    isSelected: specialty.id == "2"
                ) {
                    print("\(specialty.name) tapped")
                }
            }
        }
        .padding(.horizontal, 24)
    }
    .background(Color.gray.opacity(0.1))
}
