//
//  FontManager.swift
//  SpotCalendar
//
//  Created by 황채웅 on 3/4/25.
//

import SwiftUI

public class FontManager {
    public static func registerFonts() {
        let bundle = Bundle(for: FontManager.self)
        
        let fontNames = ["Pretendard-Bold", "Pretendard-ExtraBold", "Pretendard-Medium"]
        let fontExtension = "ttf"
        
        fontNames.forEach { fontName in
            if let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension) {
                CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, nil)
            } else {
                print("⚠️ Could not find font: \(fontName).\(fontExtension)")
            }
        }
    }
}

