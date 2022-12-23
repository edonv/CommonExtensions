//
//  View+minimumPadding.swift
//  
//  https://gist.github.com/amirdew/a7ee19de9fb9a2139e94ef155b6f5e9b
//  Created by Amir Khorsandi on 12/22/22.
//

import Foundation
import SwiftUI

@available(OSX 11, iOS 13, *)
extension View {
    /// Sets minimum padding on the set edge. The calculation takes into account safe areas.
    /// - Parameters:
    ///   - edges: Which edges to set the minimum padding for.
    ///   - length: The length the minimum amount of padding.
    /// - Returns: A view that has at least the set amount of padding on the set edges.
    func minimumPadding(edges: Edge.Set = .all, _ length: CGFloat = 8) -> some View {
        GeometryReader { geo in
            padding(.bottom, edges.contains(.bottom) ? max(length, geo.safeAreaInsets.bottom) : 0)
                .padding(.top, edges.contains(.top) ? max(length, geo.safeAreaInsets.top) : 0)
                .padding(.leading, edges.contains(.leading) ? max(length, geo.safeAreaInsets.leading) : 0)
                .padding(.trailing, edges.contains(.trailing) ? max(length, geo.safeAreaInsets.trailing) : 0)
                .ignoresSafeArea(edges: edges)
        }
    }
}
