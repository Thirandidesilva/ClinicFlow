//
//  MapView.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-03-01
//

import SwiftUI

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.showDirections {
                    DirectionsView(viewModel: viewModel)
                        .transition(.move(edge: .trailing))
                } else {
                    MainMapView(viewModel: viewModel)
                        .transition(.move(edge: .leading))
                }
            }
            .animation(.easeInOut(duration: 0.3), value: viewModel.showDirections)
            .navigationBarHidden(true)
        }
    }
}

// MARK: - : Main Map View
struct MainMapView: View {
    @ObservedObject var viewModel: MapViewModel

    var body: some View {
        VStack(spacing: 0) {

            // MARK: Fixed Header
            ZStack {
                Color.white
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Hi, Let's find the place you")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        Text("looking for")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)

                HStack {
                    Spacer()
                    NotificationButton()
                        .padding(.trailing, 16)
                }
            }
            .frame(height: 80)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {

                    // MARK: Search Bar
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(hex: "1A1AE6"))
                            .font(.system(size: 16))
                        TextField("Search", text: $viewModel.searchText)
                            .font(.body)
                        Spacer()
                        Image(systemName: "mic.fill")
                            .foregroundColor(Color(hex: "1A1AE6"))
                            .font(.system(size: 16))
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 13)
                    .background(Color.white)
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color(hex: "1A1AE6").opacity(0.35), lineWidth: 1.5)
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 12)

                    // MARK: Map Image (img_map2) — tap to go to directions
                    Button(action: { viewModel.openDirections() }) {
                        Image("img_map2")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(16)
                            .padding(.horizontal, 16)
                    }
                    .buttonStyle(.plain)

                    // MARK: Recent Visits Header
                    HStack {
                        Text("Recent Visits")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Spacer()
                        Button(action: {}) {
                            Text("See All")
                                .font(.subheadline)
                                .foregroundColor(Color(hex: "1A1AE6"))
                        }
                    }
                    .padding(.horizontal, 16)

                    // MARK: Recent Visit Cards
                    VStack(spacing: 12) {
                        ForEach(viewModel.recentVisits) { visit in
                            RecentVisitCard(visit: visit, viewModel: viewModel)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                }
            }
            .safeAreaInset(edge: .bottom) { Color.clear.frame(height: 90) }
            .background(Color(hex: "F5F5F5"))
        }
        .background(Color.white.ignoresSafeArea())
    }
}

// MARK: - Recent Visit Card
struct RecentVisitCard: View {
    let visit: RecentVisit
    @ObservedObject var viewModel: MapViewModel

    var body: some View {
        Button(action: { viewModel.openDirections() }) {
            HStack(spacing: 12) {
                Image(visit.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 64, height: 64)
                    .cornerRadius(10)
                    .clipped()

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(visit.name)
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        Spacer()
                        Text(visit.floor)
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(viewModel.floorBadgeColor(for: visit.floor))
                    }
                    Text("Speciality: \(visit.speciality)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("Available Days: \(visit.availableDays)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(12)
            .background(Color.white)
            .cornerRadius(14)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - : Directions View
struct DirectionsView: View {
    @ObservedObject var viewModel: MapViewModel

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {

                // MARK: Fixed Header
                ZStack {
                    Color.white
                    HStack {
                        Button(action: { viewModel.goBack() }) {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.primary)
                        }
                        Text("Let's find your way")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.leading, 8)
                        Spacer()
                    }
                    .padding(.horizontal, 20)

                    HStack {
                        Spacer()
                        NotificationButton()
                            .padding(.trailing, 16)
                    }
                }
                .frame(height: 60)

                // MARK: Fixed Location Fields
                VStack(spacing: 8) {
                    HStack(spacing: 10) {
                        Image(systemName: "mappin.circle")
                            .foregroundColor(Color(hex: "AAAAAA"))
                            .font(.system(size: 16))
                        Text("Location Fetched")
                            .font(.body)
                            .foregroundColor(Color(hex: "AAAAAA"))
                        Spacer()
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 13)
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex: "EEEEEE"), lineWidth: 1))

                    HStack(spacing: 10) {
                        Image(systemName: "mappin.circle")
                            .foregroundColor(Color(hex: "AAAAAA"))
                            .font(.system(size: 16))
                        Text("Location Fetched")
                            .font(.body)
                            .foregroundColor(Color(hex: "AAAAAA"))
                        Spacer()

                        // MARK: Filter Button
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                viewModel.showFloorFilter.toggle()
                            }
                        }) {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundColor(Color(hex: "1A1AE6"))
                                .font(.system(size: 15, weight: .semibold))
                                .padding(8)
                                .background(Color(hex: "1A1AE6").opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 13)
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex: "EEEEEE"), lineWidth: 1))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.white)

                // MARK: Map + Filter Dropdown overlay
                let mapHeight = geo.size.height - 60 - 110 - 90

                ZStack(alignment: .topTrailing) {

                    // Map image (img_map1)
                    // .allowsHitTesting(false) lets taps pass through to filter button above
                    Image("img_map1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: mapHeight)
                        .clipped()
                        .allowsHitTesting(false)

                    // MARK: Floor Filter Dropdown (UI 3)
                    if viewModel.showFloorFilter {
                        VStack(spacing: 0) {
                            ForEach(FloorLevel.allCases, id: \.rawValue) { floor in
                                Button(action: {
                                    viewModel.selectFloor(floor)
                                }) {
                                    HStack {
                                        Text(floor.rawValue)
                                            .font(.subheadline)
                                            .fontWeight(
                                                viewModel.selectedFloor == floor ? .bold : .regular
                                            )
                                            .foregroundColor(
                                                viewModel.selectedFloor == floor
                                                ? Color(hex: "1A1AE6")
                                                : .primary
                                            )
                                        Spacer()
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                }
                                .buttonStyle(.plain)

                                if floor != FloorLevel.allCases.last {
                                    Divider()
                                }
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
                        .frame(width: 140)
                        .padding(.top, 8)
                        .padding(.trailing, 16)
                        .zIndex(1)
                    }
                }
                .frame(width: geo.size.width, height: mapHeight)

                // Space for nav bar
                Color.white.frame(height: 90)
            }
        }
        .background(Color.white.ignoresSafeArea())
    }
}

#Preview {
    MapView()
}
