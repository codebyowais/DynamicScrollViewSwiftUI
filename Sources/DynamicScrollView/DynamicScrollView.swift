//
//  DynamicScrollView.swift
//  codebyowais
//
//  Created by Mohammed Owais on 18/09/23.
//

import SwiftUI

struct DynamicScrollView<Content>: View where Content: View {
    let showsIndicators: Bool
    let content: Content
    
    // Not taking axes because we only need this for vertical axis
    // We can fall back to default for horizontal axis
    // Shows indicators to false because we don't show indicators
    public init(showsIndicators: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.showsIndicators = showsIndicators
        self.content = content()
    }
    
    // Height State
    @State private var contentHeight: CGFloat = .zero
    
    var body: some View {
        ScrollView(showsIndicators: showsIndicators) {
            content
                .getHeight { height in
                    contentHeight = height ?? .zero
                }
        }
        .frame(maxHeight: contentHeight)
    }
}
