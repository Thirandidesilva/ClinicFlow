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
    @EnvironmentObject var tabManager: TabBarViewModel

    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabModel.mainTabs, id: \.rawValue) { tab in
                Button {
                    if tabManager.activeTab == .none {
                        tabManager.dismissSecondaryPage?()
                    }
                    activeTab = tab
                } label: {
                    HStack(spacing: 2) {
                        Image(tab.icon)
                            .renderingMode(.template)
                            .font(.title.bold())
                            .frame(width: 30, height: 30)

                        if activeTab == tab {
                            Text(tab.title)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                        }
                    }
                    .padding(.vertical, 8)
                    .foregroundStyle(activeTab == tab ? activeForeground : .black)
                    .padding(.leading, 20)
                    .padding(.trailing, 15)
                    .background {
                        if activeTab == tab {
                            Capsule()
                                .fill(activeBackground)
                        }
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 10)
        .background(Color.white)
    }
}

#Preview {
    TabBarNav()
}
