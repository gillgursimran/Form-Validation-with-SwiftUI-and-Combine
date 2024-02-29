//
//  CustomNavigationView.swift
//  SwiftUI TextField with UIKit features
//
//  Created by Gursimran Singh Gill on 2024-02-29.
//

import SwiftUI

public struct CustomNavigationView<Content: View>: View {
    let content: () -> Content

    public init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        NavigationStack() {
            content()
                .background(Colors.lightBackground)
        }
        // Prevents automatic split view on iPads.
        .navigationViewStyle(.stack)
        .navigationBarTitleDisplayMode(.inline)
        .accentColor(Colors.accentColor)
    }
}
