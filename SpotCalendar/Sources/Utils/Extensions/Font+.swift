//
//  Font+.swift
//  SpotCalendar
//
//  Created by 황채웅 on 3/4/25.
//

import SwiftUI

extension Font {
    static func defaultFont(_ fontLevel: FontLevel) -> Font {
        return Font.custom(fontLevel.fontWeight, size: fontLevel.fontSize)
    }
}
