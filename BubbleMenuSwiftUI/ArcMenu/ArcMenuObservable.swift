//
//  ArcMenuObservable.swift
//  BubbleMenuSwiftUI
//
//  Created by Ben Schultz on 12/31/19.
//  Copyright © 2019 com.concordbusinessservicesllc. All rights reserved.
//

import SwiftUI

class ArcMenuViewObservable<Item>: ObservableObject {
    @Published var menuItemSelected: Item?
    @Published var showMenu: Bool = true
    @Published var arcMenuCurve = ArcMenuCurve(start: CGPoint(x: 0, y: 0), controlPoint: CGPoint(x:0, y:0), end: CGPoint(x:0, y:0))
    @Published var menuXOffset: CGFloat = 0   // used to animate menu on and off screen
    @Published var onMenuButtonTap: (Item)->Void = { item in }
}

class ArcMenuCurve: CustomStringConvertible {
    var start: CGPoint
    var controlPoint: CGPoint
    var end: CGPoint
    
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
