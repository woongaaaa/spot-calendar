//
//  DayView.swift
//  SpotCalendar
//
//  Created by 황채웅 on 3/4/25.
//

import SwiftUI

struct DayView: View {
    var state: DayViewState
    let day: DayOfTheWeek
    let date: Int
    
    private var textColor: Color {
        switch state.time {
        case .past:
            return state.isSelected ? .white : .gray700
        case .today:
            return state.isSelected ? .white : .blue300
        case .future:
            return .gray300
        }
    }
    
    private var backgroundColor: Color {
        if state.isSelected {
            switch state.time {
            case .past: return .gray600
            case .today: return .blue300
            case .future: return .white
            }
        }
        return .white
    }

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Text(day.rawValue)
                    .font(.B2)
                    .foregroundStyle(textColor)
                    .padding(.top, 6)
                
                Text("\(date)")
                    .font(.H5)
                    .foregroundStyle(textColor)
                    .padding(.bottom, 3)
            }
            .frame(width: 45, height: 58)
            .background(backgroundColor)
            .cornerRadius(12)
            ZStack {
                if state.hasSpot {
                    Circle()
                        .strokeBorder(.white, lineWidth: 1)
                        .background(Circle().fill(.blue300))
                        .frame(width: 8, height: 8)
                        .offset(y: -3)
                } else {
                    Spacer().frame(width: 8, height: 8)
                }
            }
        }
    }
}
