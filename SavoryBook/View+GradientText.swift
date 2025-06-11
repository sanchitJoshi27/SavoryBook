//
//  View+GradientText.swift
//  SavoryBook
//
//  Created by Sanchit Joshi on 6/9/25.
//

import Foundation
import SwiftUI

extension View {
    func gradientForeground(colors: [Color]) -> some View {
        self.overlay(
            LinearGradient(
                colors: colors,
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .mask(self)
    }
}
