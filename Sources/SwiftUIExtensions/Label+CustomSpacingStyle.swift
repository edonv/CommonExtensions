//
//  Label+CustomSpacingStyle.swift
//  
//
//  Created by Edon Valdman on 3/6/23.
//

import SwiftUI

/// A custom label style that gives control over spacing and vertical alignment between icon and title in a horizontal layout.
@available(iOS 14, macOS 11, macCatalyst 14, tvOS 14, watchOS 7, *)
public struct CustomSpacingLabelStyle: LabelStyle {
    /// The guide for aligning the icon and title `View`s in this `Label`.
    /// This guide has the same vertical screen coordinate for every subview.
    public var alignment: VerticalAlignment = .center
    
    /// The distance between the icon and title `View`s in this `Label`, or `nil` if you want it to choose a default spacing.
    public var spacing: CGFloat?
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: alignment, spacing: spacing) {
            configuration.icon
            configuration.title
        }
    }
}

@available(iOS 14, macOS 11, macCatalyst 14, tvOS 14, watchOS 7, *)
extension LabelStyle where Self == CustomSpacingLabelStyle {
    /// A custom label style that gives control over spacing and vertical alignment between icon and title in a horizontal layout.
    /// - Parameters:
    ///   - alignment: The guide for aligning the icon and title `View`s in this `Label`. This guide has the same vertical screen coordinate for every subview.
    ///   - spacing: The distance between the icon and title `View`s in this `Label`, or `nil` if you want it to choose a default spacing.
    public static func customSpacing(alignment: VerticalAlignment = .center,
                                     spacing: CGFloat? = nil) -> Self {
        CustomSpacingLabelStyle(alignment: alignment,
                                spacing: spacing)
    }
}

@available(iOS 14, macOS 11, macCatalyst 14, tvOS 14, watchOS 7, *)
struct CustomSpacingLabelStyle_Previews: PreviewProvider {
    static var previews: some View {
        Label("Test Label", systemImage: "rectangle.and.pencil.and.ellipsis")
            .labelStyle(.customSpacing(alignment: .top))
    }
}
