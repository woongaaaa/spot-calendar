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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .font(.H6)
    }
}

#Preview {
    SwiftUIView()
}
