//
//  CustomButton.swift
//  SwiftUI TextField with UIKit features
//
//  Created by Gursimran Singh Gill on 2024-02-29.
//

import Foundation
import SwiftUI

public struct FilledButton: View {
    var title: String
    var icon: Icon?
    var backgroundColor: Color
    var foregroundColor: Color
    var width: Double
    var height: Double
    var titleSize: Double
    var cornerRadius: CGFloat
    var isEnabled: Bool
    var clicked: (() -> Void)

    public init(
        _ title: String,
        icon: Icon? = nil,
        backgroundColor: Color = Colors.primaryBlue,
        foregroundColor: Color = Colors.white,
        width: Double = UIScreen.width - (2 * Dimens.spacingMedium),
        height: Double = Dimens.defaultButtonHeight,
        titleSize: Double = Dimens.defaultTextSize,
        cornerRadius: CGFloat = Dimens.defaultCornerRadius,
        isEnabled: Bool = true,
        _ clicked: @escaping (() -> Void)
    ) {
        self.title = title
        self.icon = icon
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.width = width
        self.height = height
        self.titleSize = titleSize
        self.cornerRadius = cornerRadius
        self.isEnabled = isEnabled
        self.clicked = clicked
    }

    public var body: some View {
        Button(action: clicked) {
            HStack {
                Spacer()
                if icon != nil {
                    icon
                }
                Text(title)
                    .font(Font.custom("Inter-Regular", size: titleSize, relativeTo: .body))
                Spacer()
            }
        }
        .frame(width: width, height: height)
        .background(isEnabled ? backgroundColor : Colors.primaryBlue)
        .foregroundColor(isEnabled ? foregroundColor : Colors.placeholderGrey)
        .cornerRadius(cornerRadius)
        .disabled(!isEnabled)
    }
}
