//
//  WeekViewModel.swift
//  SpotCalendar
//
//  Created by 황채웅 on 3/7/25.
//

import SwiftUI

final class WeekViewModel: ObservableObject {
    @Published var days: [DayViewState] = []

    init(date: Date) {
        generateWeekDays(for: date)
    }

    func generateWeekDays(for baseDate: Date) {
        let calendar = Calendar.current
        let today = Date()
        let startOfWeek = calendar.startOfDay(for: calendar.date(byAdding: .day, value: -(calendar.component(.weekday, from: baseDate) - 1), to: baseDate)!)

        days = (0..<7).map { index in
            let date = calendar.date(byAdding: .day, value: index, to: startOfWeek)!
            let dayComponent = calendar.component(.day, from: date)

            return DayViewState(
                date: dayComponent,
                isSelected: calendar.isDate(baseDate, inSameDayAs: date),
                time: calendar.isDate(today, inSameDayAs: date) ? .today : (today < date ? .future : .past),
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
