//
//  SwiftUIView.swift
//  SpotCalendar
//
//  Created by 황채웅 on 3/4/25.
//

import SwiftUI

public struct SwiftUIView: View {
    
    public init() {
        FontManager.registerFonts()
    }

    public var body: some View {
        VStack {
            Text("캘린더 테스트")
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 30)
            
            WeekView()
                .padding(.top, 20)
            
            Spacer()
        }
    }
}

#Preview {
    SwiftUIView()
}
