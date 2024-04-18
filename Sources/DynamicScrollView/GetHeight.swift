//
//  CalculateHeightModifier.swift
//  codebyowais
//
//  Created by Mohammed Owais on 11/09/23.
//

import SwiftUI

private struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat?

    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        guard let nextValue = nextValue() else { return }
        value = nextValue
    }
}

private struct CalculateHeightModifier: ViewModifier {
    private var sizeView: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: HeightPreferenceKey.self, value: geometry.size.height)
        }
    }

    func body(content: Content) -> some View {
        content.background(sizeView)
    }
}

extension View {
    func calculateHeight() -> some View {
        modifier(CalculateHeightModifier())
    }
    
    func getHeight(perform: @escaping (CGFloat?) -> Void) -> some View {
        calculateHeight()
            .onPreferenceChange(HeightPreferenceKey.self, perform: perform)
    }
}
