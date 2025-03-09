//
//  CalendarViewModel.swift
//  SpotCalendar
//
//  Created by 황채웅 on 3/9/25.
//

import UIKit
import Combine

final class CalendarViewModel: ViewModelable {
    // MARK: Types
    enum Action {
        case willSelectDate(_ at: Date)
        case didTapTodayButton
        case willScrollToPreviousWeek(_ at: Date)
        case willScrollToNextWeek(_ at: Date)
    }
    
    enum State: Equatable {
        case selectedDayOfTheWeek(DayOfTheWeek)
        case selectedYearAndMonth(year: Int, month: Int)
        case selectedWeek(firstDayOfTheWeek: Date, days: [DayViewState])
        
        static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case (.selectedDayOfTheWeek(let day1), .selectedDayOfTheWeek(let day2)):
                return day1 == day2
            case (.selectedYearAndMonth(let year1, let month1), .selectedYearAndMonth(let year2, let month2)):
                return year1 == year2 && month1 == month2
            case (.selectedWeek(let firstDay1, let days1), .selectedWeek(let firstDay2, let days2)):
                return firstDay1.isSameDay(date: firstDay2) && days1 == days2
            default:
                return false
            }
        }
    }
    
    // MARK: Properties
    @Published var state: State
    private var cancellables = Set<AnyCancellable>()
    private var selectedDayOfWeek: DayOfTheWeek?
    
    // MARK: Initializer
    init() {
        let today = Date()
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
        
        state = .selectedWeek(firstDayOfTheWeek: startOfWeek, days: [])
        selectedDayOfWeek = today.getDayOfTheWeek() // Default to today’s day of week
        state = .selectedWeek(firstDayOfTheWeek: startOfWeek, days: generateWeekDays(from: startOfWeek))
    }
    
    // MARK: Action
    func action(_ action: Action) {
        let calendar = Calendar.current
        switch action {
        case .willSelectDate(let date):
            if case .selectedWeek(let firstDay, let days) = state {
                if date.getDayViewTime() != .future {
                    selectedDayOfWeek = date.getDayOfTheWeek()
                    let newDays = days.map { dayState in
                        DayViewState(
                            date: dayState.date,
                            isSelected: dayState.date.isSameDay(date: date),
                            time: dayState.time,
                            hasSpot: dayState.hasSpot
                        )
                    }
                    state = .selectedWeek(firstDayOfTheWeek: firstDay, days: newDays)
                }
            }
            
        case .didTapTodayButton:
            let today = Date()
            let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
            selectedDayOfWeek = today.getDayOfTheWeek()
            state = .selectedWeek(firstDayOfTheWeek: startOfWeek, days: generateWeekDays(from: startOfWeek))
            
        case .willScrollToPreviousWeek(let date):
            if let newStart = calendar.date(byAdding: .day, value: -7, to: date) {
                state = .selectedWeek(firstDayOfTheWeek: newStart, days: generateWeekDays(from: newStart))
            }
            
        case .willScrollToNextWeek(let date):
            if let newStart = calendar.date(byAdding: .day, value: 7, to: date) {
                state = .selectedWeek(firstDayOfTheWeek: newStart, days: generateWeekDays(from: newStart))
            }
        }
    }
    
    func generateWeekDays(from startDate: Date) -> [DayViewState] {
        let calendar = Calendar.current
        var days: [DayViewState] = []
        
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: i, to: startDate) {
                let isSelected = selectedDayOfWeek == date.getDayOfTheWeek()
                days.append(DayViewState(
                    date: date,
                    isSelected: isSelected,
                    time: date.getDayViewTime(),
                    hasSpot: true
                ))
            }
        }
        
        if !days.contains(where: { $0.isSelected }), let todayIndex = days.firstIndex(where: { $0.time == .today }) {
            days[todayIndex].isSelected = true
            selectedDayOfWeek = days[todayIndex].date.getDayOfTheWeek()
        } else if !days.contains(where: { $0.isSelected }), let pastIndex = days.firstIndex(where: { $0.time == .past }) {
            days[pastIndex].isSelected = true
            selectedDayOfWeek = days[pastIndex].date.getDayOfTheWeek()
        }
        
        return days
    }
}
