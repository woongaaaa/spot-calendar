//
//  WeekView.swift
//  SpotCalendar
//
//  Created by 황채웅 on 3/4/25.
//

import SwiftUI

struct WeekView: View {
    @StateObject private var viewModel = WeekViewModel()
    
    let screenWidth = UIScreen.main.bounds.width
    
    init() {
        FontManager.registerFonts()
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: (UIScreen.main.bounds.width-45*7-30)/6) {
            ForEach(0..<7, id: \.self) { index in
                DayView(
                    state: viewModel.days[index],
                    day: DayOfTheWeek.allCases[index],
                    date: viewModel.days[index].date
                )
                .onTapGesture {
                    if viewModel.days[index].time != .future {
                        viewModel.selectDay(at: index)
                    }
                }
            }
        }
    }
}

#Preview {
    WeekView()
}
