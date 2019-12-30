//
//  MenuCurve.swift
//  BubbleMenuSwiftUI
//
//  Created by Ben Schultz on 12/27/19.
//  Copyright © 2019 com.concordbusinessservicesllc. All rights reserved.
//

import SwiftUI

class ArcMenuCurve: ObservableObject, CustomStringConvertible {
    @Published var start: CGPoint
    @Published var controlPoint: CGPoint
    @Published var end: CGPoint
    
    private var count = 0
    
    init (start: CGPoint, controlPoint: CGPoint, end: CGPoint) {
        self.start = start
        self.controlPoint = controlPoint
        self.end = end
    }
    
    var description: String {
        count += 1
        return ("start: \(start)   controlPoint: \(controlPoint)   end: \(end)   count: \(count)")
        
    }
}
