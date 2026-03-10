//
//  ActivityView.swift
//  ClinicFlow
//  Created by Thirandi De Silva on 2026-02-25

import SwiftUI

// MARK: - ActivityView

struct ActivityView: View {

    @StateObject private var viewModel = ActivityViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "FFFFFF")
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 0) {

                    // MARK: Title
                    Text("My Bookings")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading, 24)
                        .padding(.top, 16)
                        .padding(.bottom, 20)

                    // MARK: Tab Selector
                    BookingTabSelector(selectedTab: $viewModel.selectedTab)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 20)

                    // MARK: Content
                    ScrollView {
                        VStack(spacing: 14) {
                            switch viewModel.selectedTab {

                            case .upcoming:
                                if viewModel.upcomingBookings.isEmpty {
                                    UpcomingEmptyStateView()
                                        .padding(.top, 60)
                                } else {
                                    ForEach(viewModel.upcomingBookings) { booking in
                                        UpcomingBookingCard(booking: booking) {
                                            viewModel.requestCancel(booking: booking)
                                        }
                                    }
                                }

                            case .completed:
                                ForEach(viewModel.completedBookings) { booking in
                                    CompletedBookingCard(booking: booking) {
                                        viewModel.requestReview(booking: booking)
                                    }
                                }

                            case .cancelled:
                                ForEach(viewModel.cancelledBookings) { booking in
                                    CancelledBookingCard(booking: booking)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                }

                // MARK: Notification Button
                NotificationButton()
            }
            .navigationBarHidden(true)

            // MARK: Cancel Sheet
            .sheet(isPresented: $viewModel.showCancelSheet) {
                CancelAppointmentSheet(
                    onNoCancel: { viewModel.dismissCancel() },
                    onYesCancel: { viewModel.confirmCancel() }
                )
                .presentationDetents([.height(400)])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(28)
                .presentationBackground(.white)
            }

            // MARK: Review Sheet
            .sheet(isPresented: $viewModel.showReviewSheet) {
                AddReviewSheet(
                    rating: $viewModel.reviewRating,
                    reviewText: $viewModel.reviewText,
                    onSubmit: { viewModel.submitReview() }
                )
                .presentationDetents([.height(420)])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(28)
                .presentationBackground(.white)
            }
        }
    }
}

// MARK: - Tab Selector

struct BookingTabSelector: View {
    @Binding var selectedTab: BookingTab

    var body: some View {
        HStack(spacing: 10) {
            TabPill(title: "Upcoming",  isSelected: selectedTab == .upcoming)  { selectedTab = .upcoming }
            TabPill(title: "Completed", isSelected: selectedTab == .completed) { selectedTab = .completed }
            TabPill(title: "Cancelled", isSelected: selectedTab == .cancelled) { selectedTab = .cancelled }
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
    let onCancelTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            DoctorRowHeader(booking: booking)

            HStack(spacing: 12) {
                // Cancel Booking — triggers bottom sheet
                Button(action: onCancelTap) {
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
                        .background(Capsule().fill(Color(hex: "1A3CE8")))
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
    let onAddReviewTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            DoctorRowHeader(booking: booking)

            HStack(spacing: 12) {
                // Re-Book — placeholder navigation
                NavigationLink {
                    Text("Navigating to book page")
                        .font(.title3)
                        .foregroundColor(.gray)
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

                // Add Review — triggers bottom sheet
                Button(action: onAddReviewTap) {
                    Text("Add Review")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(Capsule().fill(Color(hex: "1A3CE8")))
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

// MARK: - Upcoming Empty State

struct UpcomingEmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("img_Anotice")
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 140)

            Text("You don't have any upcoming\nappointments at the moment")
                .font(.subheadline)
                .foregroundColor(Color(hex: "AAAAAA"))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Cancel Appointment Sheet

struct CancelAppointmentSheet: View {
    let onNoCancel: () -> Void
    let onYesCancel: () -> Void

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 20) {
                Image("img_Across")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 72, height: 72)
                    .padding(.top, 10)

                Text("Cancel Appointment ?")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "E84040"))

                Text("This will permanently remove your slot.\nRescheduling may take longer if cancelled.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)

                HStack(spacing: 16) {
                    Button(action: onNoCancel) {
                        Text("No, Don't Cancel")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(Color(hex: "1A1A2E"))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 13)
                            .overlay(
                                Capsule()
                                    .stroke(Color(hex: "CCCCCC"), lineWidth: 1.2)
                            )
                    }

                    Button(action: onYesCancel) {
                        Text("Yes, Cancel")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 13)
                            .background(Capsule().fill(Color(hex: "E84040")))
                    }
                }
                .padding(.bottom, 10)
            }
            .padding(.horizontal, 28)
            .padding(.top, 8)
            .padding(.bottom, 34)
        }
    }
}

// MARK: - Add Review Sheet

struct AddReviewSheet: View {
    @Binding var rating: Int
    @Binding var reviewText: String
    let onSubmit: () -> Void

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 18) {
                Text("How is Your Experience?")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "1A1A2E"))
                    .padding(.top, 16)

                Text("Please take a moment to rate and review")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                // Star Rating
                HStack(spacing: 10) {
                    ForEach(1...5, id: \.self) { star in
                        Image(systemName: star <= rating ? "star.fill" : "star")
                            .font(.title2)
                            .foregroundColor(star <= rating ? .yellow : Color(hex: "DDDDDD"))
                            .onTapGesture {
                                rating = star
                            }
                    }
                }

                // Review Text Field + Send Button
                HStack(spacing: 10) {
                    TextField("Type a review", text: $reviewText)
                        .font(.subheadline)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 13)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color(hex: "E0E0E0"), lineWidth: 1.2)
                        )

                    Button(action: onSubmit) {
                        Image(systemName: "paperplane.fill")
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Circle().fill(Color(hex: "1A3CE8")))
                    }
                }
                .padding(.bottom, 34)
            }
            .padding(.horizontal, 28)
        }
    }
}

// MARK: - Preview

#Preview {
    ActivityView()
}
