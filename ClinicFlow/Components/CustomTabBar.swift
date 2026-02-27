//
//  CustomTabBar.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-24.
//

import SwiftUI

struct CustomTabBar: View {
    var activeForeground: Color = .white
    var activeBackground: Color = Color(hex: "0930A6")
    @Binding var activeTab: TabModel

    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabModel.allCases, id: \.rawValue) { tab in
                Button {
                    activeTab = tab
                } label: {
                    HStack(spacing: 6) {
                        Image(tab.icon)
                            .renderingMode(.template)
                            .font(.title.bold())
                            .frame(width: 24, height: 24)

                        if activeTab == tab {
                            Text(tab.title)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .fixedSize() // never truncate
                        }
                    }
                    .padding(.vertical, 11)
                    .padding(.horizontal, 14)
                    .foregroundStyle(activeTab == tab ? activeForeground : .black)
                    .background {
                        if activeTab == tab {
                            Capsule()
                                .fill(activeBackground)
                        }
                    }
                }
                .buttonStyle(.plain)
                // inactive tabs share remaining space equally
                if activeTab != tab {
                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.top, 12)
        .padding(.bottom, 23)
        .background(Color.white)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(hex: "E5E5E5")),
            alignment: .top
        )
    }
}

#Preview {
    TabBarNav()
}
