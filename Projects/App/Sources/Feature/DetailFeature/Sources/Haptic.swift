//
//  Haptic.swift
//  GPle
//
//  Created by 서지완 on 12/16/24.
//  Copyright © 2024 GSM.GPle. All rights reserved.
//

import SwiftUI

final class Haptic {
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }

    static func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
