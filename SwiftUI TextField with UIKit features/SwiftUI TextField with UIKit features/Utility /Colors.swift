//
//  Colors.swift
//  SwiftUI TextField with UIKit features
//
//  Created by Gursimran Singh Gill on 2024-02-29.
//

import Foundation
import SwiftUI

public class Colors {
    public static let primaryBlue = Color.rgb(84, 165, 211)
    public static let lightBackground = Color.rgb(240, 242, 242)
    public static let white = Color.white
    public static let placeholderGrey = Color.rgb(199, 199, 205)
    public static let textFieldBackground = Color.rgb(239, 241, 243)
    public static let primaryGrey = Color.rgb(52, 58, 64)
    public static let red = Color.rgb(255, 4, 67)
    public static let orange = Color.rgb(255, 118, 0)
    public static let appFooterGrey = Color.rgb(130, 133, 135)
    public static let black = Color.black
    public static let accentColor = Color.white
    public static let cursorColor = primaryBlue
}

public extension Color {
    static func rgb(_ red: Int, _ green: Int, _ blue: Int) -> Color {
        return Color(red: Double(red) / 255.0, green: Double(green) / 255.0, blue: Double(blue) / 255.0)
    }
}
