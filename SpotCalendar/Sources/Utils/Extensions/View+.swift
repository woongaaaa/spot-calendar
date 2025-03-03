//
//  View+.swift
//  SpotCalendar
//
//  Created by 황채웅 on 3/4/25.
//

import SwiftUI

extension View {
    func font(_ font: FontLevel) -> some View {
        let fontSpacing = (font.lineHeight - font.fontSize) / 2
        
        return self
            .font(Font.defaultFont(font))
            .padding(.vertical, fontSpacing)
            .lineSpacing(fontSpacing * 2)
    }
}
