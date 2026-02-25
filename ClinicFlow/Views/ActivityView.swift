//
//  ActivityView.swift
//  ClinicFlow
//

import SwiftUI

struct ActivityView: View {

    @StateObject private var viewModel = ActivityViewModel()
    @State private var showNotifications = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "FFFFFF")
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 0) {

                    // MARK: - Title
                    Text("My Bookings")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading, 24)
                        .padding(.top, 16)
                        .padding(.bottom, 20)

                    // MARK: - Tab Selector
                    BookingTabSelector(selectedTab: $viewModel.selectedTab)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 20)

                    // MARK: - Booking List
                    ScrollView {
                        VStack(spacing: 14) {
                            ForEach(viewModel.filteredBookings) { booking in
                                switch viewModel.selectedTab {
                                case .upcoming:
                                    UpcomingBookingCard(booking: booking)
                                case .completed:
                                    CompletedBookingCard(booking: booking)
                                case .cancelled:
                                    CancelledBookingCard(booking: booking)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                }

                // MARK: - Notification Button
                NotificationButton()
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Tab Selector

struct BookingTabSelector: View {
    @Binding var selectedTab: BookingTab

    var body: some View {
        HStack(spacing: 10) {
            TabPill(title: "Upcoming",   isSelected: selectedTab == .upcoming)   { selectedTab = .upcoming }
            TabPill(title: "Completed",  isSelected: selectedTab == .completed)  { selectedTab = .completed }
            TabPill(title: "Cancelled",  isSelected: selectedTab == .cancelled)  { selectedTab = .cancelled }
        }
    }
}

struct TabPill: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .white : Color(hex: "1A1A2E"))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(isSelected ? Color(hex: "1A3CE8") : Color.clear)
                )
                .overlay(
                    Capsule()
                        .stroke(Color(hex: "1A3CE8"), lineWidth: isSelected ? 0 : 1.2)
                )
        }
    }
}

// MARK: - Shared Doctor Row Header

struct DoctorRowHeader: View {
    let booking: BookingModel

    var body: some View {
        HStack(spacing: 14) {
            Image(booking.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 72)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 4) {
                Text(booking.doctorName)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "1A1A2E"))

                Text(booking.speciality)
                    .font(.caption)
                    .foregroundColor(.gray)

                Text("\(booking.date) - \(booking.time)")
                    .font(.caption)
                    .foregroundColor(.gray)

                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.caption2)
                    Text("\(Int(booking.rating)) | \(booking.reviewCount) Reviews")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
    }
}

// MARK: - Upcoming Booking Card

struct UpcomingBookingCard: View {
    let booking: BookingModel

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            DoctorRowHeader(booking: booking)

            HStack(spacing: 12) {
                // Cancel Booking
                Button {
                    Text("Navigate to cancel booking")
                } label: {
                    Text("Cancel Booking")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(Color(hex: "E84040"))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color(hex: "E84040"), lineWidth: 1.2)
                        )
                }

                // View Details
                NavigationLink {
                    Text("Navigate to details page")
                } label: {
                    Text("View Details")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(Color(hex: "1A3CE8"))
                        )
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.07), radius: 8, x: 0, y: 2)
        )
    }
}

// MARK: - Completed Booking Card

struct CompletedBookingCard: View {
    let booking: BookingModel

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            DoctorRowHeader(booking: booking)

            HStack(spacing: 12) {
                // Re-Book
                Button {
                    // Navigate to re-book page
                    _ = Text("Navigate to re-book page")
                } label: {
                    Text("Re - Book")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(Color(hex: "1A3CE8"))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color(hex: "1A3CE8"), lineWidth: 1.2)
                        )
                }

                // Add Review
                NavigationLink {
                    Text("Navigate to add review page")
                } label: {
                    Text("Add Review")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(Color(hex: "1A3CE8"))
                        )
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.07), radius: 8, x: 0, y: 2)
        )
    }
}

// MARK: - Cancelled Booking Card

struct CancelledBookingCard: View {
    let booking: BookingModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            DoctorRowHeader(booking: booking)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.07), radius: 8, x: 0, y: 2)
        )
    }
}

// MARK: - Preview

#Preview {
    ActivityView()
}
