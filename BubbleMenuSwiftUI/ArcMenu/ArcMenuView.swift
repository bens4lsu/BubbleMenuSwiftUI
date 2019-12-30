//
//  ContentView.swift
//  BubbleMenuSwiftUI
//
//  Created by Ben Schultz on 11/13/19.
//  Copyright © 2019 com.concordbusinessservicesllc. All rights reserved.
//


// TODO:  Make the scroll stick.  https://blog.process-one.net/writing-a-custom-scroll-view-with-swiftui-in-a-chat-application/


import SwiftUI

protocol ArcMenuViewItem: Hashable {
    associatedtype T: View
    var view: T { get }
}

struct ArcMenuView<Item>: View where Item:ArcMenuViewItem {
    
    @ObservedObject var curve = ArcMenuCurve(start: CGPoint(x: 0, y: 0), controlPoint: CGPoint(x:0, y:0), end: CGPoint(x:0, y:0))
    
    var items: [Item]
    
    var body: some View {
        
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                let startX = min(width * ArcMenuConstants.curveStartFactor, ArcMenuConstants.maxStartX)
                let curveStart = CGPoint(x: startX, y: 0)
                let curveControlPointX = min (width * ArcMenuConstants.curveControlPointFactor, ArcMenuConstants.maxControlPointX)
                let curveControlPoint = CGPoint(x: curveControlPointX, y: height * 0.5)
                
                let curveEnd = CGPoint(x: startX, y: height)
                
                if !(self.curve.start == curveStart && self.curve.controlPoint == curveControlPoint && self.curve.end == curveEnd) {
                    self.curve.start = curveStart
                    self.curve.controlPoint = curveControlPoint
                    self.curve.end = curveEnd
                }
                
                print (self.curve)
                
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: curveStart)
                path.addQuadCurve(to: curveEnd, control: curveControlPoint)
                path.addLine(to: CGPoint(x: 0, y: height))
                
            }.fill(ArcMenuConstants.bgColor)
            VStack{
                ScrollView {
                    ForEach(self.items, id: \.self) { item in 
                        ArcMenuCell(curve: self.curve, item: item)
                    }

                }
            }
        }
    }
}

struct ArcMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ArcMenuView(items: [MyMenuItem(name: "Item 1")])
    }
}
