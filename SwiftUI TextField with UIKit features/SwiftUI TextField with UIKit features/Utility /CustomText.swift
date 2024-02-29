//
//  CustomText.swift
//  SwiftUI TextField with UIKit features
//
//  Created by Gursimran Singh Gill on 2024-02-29.
//

import Foundation
import SwiftUI
import UIKit

public struct OurText: View {
    var text: String
    var size: CGFloat?
    var color: Color?
    var fontWeight: Font.Weight?
    var fontStyle: Font.TextStyle
    var font: String?

    public init(
        _ text: String,
        size: CGFloat = Dimens.defaultTextSize,
        color: Color = .black,
        fontWeight: Font.Weight = .regular,
        fontStyle: Font.TextStyle = .body,
        font: String = "Inter-Regular"
    ) {
        self.text = text
        self.size = size
        self.color = color
        self.fontWeight = fontWeight
        self.fontStyle = fontStyle
        self.font = font
    }

    public var body: some View {
        Text(text)
            .modifier(CustomText(size: size!, color: color!, fontWeight: fontWeight!, fontStyle: fontStyle, font: font!))
    }
 }

struct CustomText: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var size: CGFloat
    var color: Color
    var fontWeight: Font.Weight
    var fontStyle: Font.TextStyle = .body
    var font: String

    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content
                   .font(.custom(font, size: scaledSize, relativeTo: fontStyle)
                   .weight(fontWeight))
                   .foregroundColor(color)
    }
}

extension View {
    public func customText(
        size: CGFloat = Dimens.defaultTextSize,
        color: Color = .black,
        fontWeight: Font.Weight = .regular,
        fontStyle: Font.TextStyle = .body,
        font: String = "Inter-Regular"
    ) -> some View {
        return self.modifier(CustomText(size: size, color: color, fontWeight: fontWeight, fontStyle: fontStyle, font: font))
    }
}

