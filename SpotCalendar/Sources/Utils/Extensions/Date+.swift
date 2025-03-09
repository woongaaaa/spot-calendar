//
//  Date+.swift
//  SpotCalendar
//
//  Created by 황채웅 on 3/9/25.
//

import Foundation

extension Date {
    func isSameDay(date: Date) -> Bool {
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.year, .month, .day], from: self)
        let components2 = calendar.dateComponents([.year, .month, .day], from: date)
        
        return components1.year == components2.year &&
        components1.month == components2.month &&
        components1.day == components2.day
    }
    
    func isToday() -> Bool {
        let calendar = Calendar.current
        let today = Date()
        let components1 = calendar.dateComponents([.year, .month, .day], from: today)
        let components2 = calendar.dateComponents([.year, .month, .day], from: self)
        
        return components1.year == components2.year &&
        components1.month == components2.month &&
        components1.day == components2.day
    }
    
    func getYearAndMonth() -> (year: Int, month: Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        
        return (year: components.year ?? 0, month: components.month ?? 0)
    }
    
    func getDayOfTheWeek() -> DayOfTheWeek {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: self)
        switch weekday {
        case 1: return .sunday
        case 2: return .monday
        case 3: return .tuesday
        case 4: return .wednesday
        case 5: return .thursday
        case 6: return .friday
        case 7: return .saturday
        default: return .sunday
        }
    }
    
    func getDay() -> Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: self)
    }
    
    func getDayViewTime() -> DayViewTime {
        let calendar = Calendar.current
        let today = Date()
        
        if self.isToday() {
            return .today
        }
        
        let todayComponents = calendar.dateComponents([.year, .month, .day], from: today)
        let inputComponents = calendar.dateComponents([.year, .month, .day], from: self)
        
        guard let todayDate = calendar.date(from: todayComponents),
              let inputDate = calendar.date(from: inputComponents) else {
            return .today
        }
        
        return inputDate > todayDate ? .future : .past
    }
    
    static func date(from dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: dateString)
    }
}
