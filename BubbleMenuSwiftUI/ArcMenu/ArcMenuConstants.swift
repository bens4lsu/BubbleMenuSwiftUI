//
//  File.swift
//  BubbleMenuSwiftUI
//
//  Created by Ben Schultz on 12/27/19.
//  Copyright © 2019 com.concordbusinessservicesllc. All rights reserved.
//

import SwiftUI

struct ArcMenuConstants {
    
    static let bgColor = Color.black
    
    // MARK: control the curviness of the background
    static let curveStartFactor: CGFloat = 0.25
    static let curveControlPointFactor: CGFloat = 0.80
    
    // MARK: limit the amount of real estate the menu will use on wide screens
    // max-X to use for top and bottom of curve
    static let maxStartX: CGFloat = 250
    // max bulge in the curve
    static let maxControlPointX: CGFloat = Self.maxStartX + 370.0
        
    // MARK: control menuCell properties
    struct Cell {
        static let maxHeight: CGFloat = 180
        static let minHeight: CGFloat = 30
        static let widthFactor: CGFloat = 0.78
        static let bulgeFactor: CGFloat = 0.05
        static let bottomPadding: CGFloat = 5.0
        static let topPadding: CGFloat = 50.0
        static let bgColor = Color.gray
        
    }
}
