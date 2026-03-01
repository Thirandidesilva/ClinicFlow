//
//  Calendar.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-01.
//

import SwiftUI

struct CustomCalendarView: View {
    @State private var selectedDate = Date()
    @State private var currentMonth = Date()
    
    private let calendar = Calendar.current
    private let daysOfWeek = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Month Header
            HStack {
                Button(action: previousMonth) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color(hex: "1E3A8A"))
                }
                
                Spacer()
                
                Text(monthYearString)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(hex: "1E3A8A"))
                
                Spacer()
                
                Button(action: nextMonth) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color(hex: "1E3A8A"))
                }
            }
            .frame(height: 40)
            .padding(.horizontal, 20)
            
            // MARK: - Divider
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 1)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
            
            // MARK: - Days of Week
            HStack(spacing: 0) {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
            .frame(height: 25)
            .padding(.horizontal, 20)
            
            // MARK: - Calendar Grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 7), spacing: 12) {
                ForEach(daysInMonth, id: \.self) { day in
                    if day > 0 {
                        DayCell(
                            day: day,
                            isSelected: isSelectedDay(day),
                            isToday: isTodayDay(day)
                        )
                        .onTapGesture {
                            selectDay(day)
                        }
                    } else {
                        Text("")
                            .frame(width: 38, height: 38)
                    }
                }
            }
            .frame(height: 260)
            .padding(.horizontal, 20)
            .padding(.top, 12)
            
            Spacer()
        }
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 8)
        )
        .frame(width: 340, height: 420)
        .fixedSize()
        .padding(.horizontal, 20)
    }
    
    // MARK: - Helper Functions
    private var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentMonth)
    }
    
    private var daysInMonth: [Int] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: currentMonth) else {
            return []
        }
        
        let monthStart = monthInterval.start
        let daysInMonth = calendar.range(of: .day, in: .month, for: monthStart)?.count ?? 0
        
        // Get the weekday of the first day (1 = Sunday, 2 = Monday, etc.)
        let firstWeekday = calendar.component(.weekday, from: monthStart)
        
        // Adjust to make Monday = 0
        let emptySlots = (firstWeekday + 5) % 7
        
        var days: [Int] = Array(repeating: 0, count: emptySlots)
        days.append(contentsOf: 1...daysInMonth)
        
        return days
    }
    
    private func isSelectedDay(_ day: Int) -> Bool {
        let selectedDay = calendar.component(.day, from: selectedDate)
        let selectedMonth = calendar.component(.month, from: selectedDate)
        let currentMonthNumber = calendar.component(.month, from: currentMonth)
        
        return day == selectedDay && selectedMonth == currentMonthNumber
    }
    
    private func isTodayDay(_ day: Int) -> Bool {
        let today = Date()
        let todayDay = calendar.component(.day, from: today)
        let todayMonth = calendar.component(.month, from: today)
        let currentMonthNumber = calendar.component(.month, from: currentMonth)
        
        return day == todayDay && todayMonth == currentMonthNumber
    }
    
    private func selectDay(_ day: Int) {
        let components = DateComponents(
            year: calendar.component(.year, from: currentMonth),
            month: calendar.component(.month, from: currentMonth),
            day: day
        )
        if let newDate = calendar.date(from: components) {
            selectedDate = newDate
        }
    }
    
    private func previousMonth() {
        currentMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth) ?? currentMonth
    }
    
    private func nextMonth() {
        currentMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth) ?? currentMonth
    }
}

// MARK: - Day Cell Component
struct DayCell: View {
    let day: Int
    let isSelected: Bool
    let isToday: Bool
    
    var body: some View {
        ZStack {
            if isSelected {
                // Selected date - filled blue circle
                Circle()
                    .fill(Color(hex: "0930A6"))
                    .frame(width: 38, height: 38)
            } else if isToday {
                // Today - blue outline circle
                Circle()
                    .stroke(Color(hex: "0930A6"), lineWidth: 2)
                    .frame(width: 38, height: 38)
            }
            
            Text("\(day)")
                .font(.system(size: 16, weight: isSelected || isToday ? .bold : .regular))
                .foregroundColor(isSelected ? .white : Color(hex: "1E3A8A"))
        }
        .frame(height: 38)
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.1)
            .ignoresSafeArea()
        
        CustomCalendarView()
    }
}
