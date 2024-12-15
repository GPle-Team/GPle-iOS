//
//  FlowLayout.swift
//  GPle
//
//  Created by 서지완 on 12/15/24.
//  Copyright © 2024 GSM.GPle. All rights reserved.
//

import SwiftUI

struct FlowLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        return layout(sizes: sizes, proposal: proposal).size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let offsets = layout(sizes: sizes, proposal: proposal).offsets
        for (offset, subview) in zip(offsets, subviews) {
            subview.place(at: CGPoint(x: offset.x + bounds.minX, y: offset.y + bounds.minY), proposal: .unspecified)
        }
    }

    private func layout(sizes: [CGSize], proposal: ProposedViewSize) -> (offsets: [CGPoint], size: CGSize) {
        let spacing: CGFloat = 12
        let containerWidth = proposal.width ?? .infinity
        let leadingForSecondLine: CGFloat = 60

        var offsets: [CGPoint] = []
        var currentPosition: CGPoint = .zero
        var maxY: CGFloat = 0
        var isFirstLine = true

        for size in sizes {
            if currentPosition.x + size.width > containerWidth {
                currentPosition.x = isFirstLine ? leadingForSecondLine : 0
                currentPosition.y = maxY + spacing
                isFirstLine = false
            }
            offsets.append(currentPosition)
            currentPosition.x += size.width + spacing
            maxY = max(maxY, currentPosition.y + size.height)
        }

        return (offsets, CGSize(width: containerWidth, height: maxY))
    }

}
