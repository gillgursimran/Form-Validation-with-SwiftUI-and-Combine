//
//  Icon.swift
//  EasyPark
//
//  Created by Gursimran Singh Gill on 2023-07-21.
//

import SwiftUI

public struct Icon: View {
    var name: String
    var bundle: Bundle
    var color: Color?
    var size: CGFloat
    var resizable: Bool
    var renderingMode: Image.TemplateRenderingMode

    public init(
        _ name: String,
        bundle: Bundle,
        color: Color? = nil,
        size: CGFloat = Dimens.iconSize,
        resizable: Bool = false,
        renderingMode: Image.TemplateRenderingMode = .template
    ) {
        self.name = name
        self.bundle = bundle
        self.color = color
        self.size = size
        self.resizable = resizable
        self.renderingMode = renderingMode
    }

    public var body: some View {
        if resizable {
            Image(name, bundle: bundle)
                .resizable()
                .renderingMode(renderingMode)
                .foregroundColor(color ?? .black)
                .frame(width: size, height: size)
        } else {
            Image(name, bundle: bundle)
                .renderingMode(renderingMode)
                .foregroundColor(color ?? .black)
        }
    }
}
