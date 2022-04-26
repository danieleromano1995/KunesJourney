//
//  File.swift
//  Kune's Journey
//
//  Created by Jarvis on 24/04/22.
//

import Foundation
import SwiftUI

public struct MyFonts {
    public static func registerFonts() {
        registerFont(bundle: Bundle.main , fontName: "SF-Pro", fontExtension: ".ttf")
    }
    
    fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {

            guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
                  let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
                  let font = CGFont(fontDataProvider) else {
                      fatalError("Couldn't create font from data")
            }

            var error: Unmanaged<CFError>?

            CTFontManagerRegisterGraphicsFont(font, &error)
        }
}
