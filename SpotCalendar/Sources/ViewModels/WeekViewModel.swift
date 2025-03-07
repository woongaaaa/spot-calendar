//
//  WeekViewModel.swift
//  SpotCalendar
//
//  Created by 황채웅 on 3/7/25.
//

import SwiftUI

class WeekViewModel: ObservableObject {
    @Published var days: [DayViewState] = []

    init() {
        generateWeekDays(for: Date())
    }

    func generateWeekDays(for baseDate: Date) {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: baseDate) - 1
        let startOfWeek = calendar.date(byAdding: .day, value: -weekday, to: baseDate)!

        days = (0..<7).map { index in
            let date = calendar.date(byAdding: .day, value: index, to: startOfWeek)!
            let dayComponent = calendar.component(.day, from: date)

            return DayViewState(
                date: dayComponent,
                isSelected: calendar.isDate(baseDate, inSameDayAs: date),
                time: baseDate < date ? .future : (baseDate > date ? .past : .today),
                hasSpot: Bool.random()
            )
        }
    }

    func selectDay(at index: Int) {
        for i in days.indices {
            days[i].isSelected = (i == index)
        }
    }
}
