//
//  DayViewState.swift
//  SpotCalendar
//
//  Created by 황채웅 on 3/4/25.
//

import SwiftUI

struct DayViewState: Identifiable {
    let id: UUID = UUID()
    
    var date: Int
    var isSelected: Bool
    var time: DayViewTime
    var hasSpot: Bool
}


enum DayViewTime {
    case today
    case future
    case past
}
