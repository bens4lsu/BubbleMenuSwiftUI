//
//  ContentView.swift
//  BubbleMenuSwiftUI
//
//  Created by Ben Schultz on 11/13/19.
//  Copyright © 2019 com.concordbusinessservicesllc. All rights reserved.
//


import SwiftUI

struct ArcMenuView<Item>: View where Item:ArcMenuViewItem {
    
    @ObservedObject var curve = ArcMenuCurve(start: CGPoint(x: 0, y: 0), controlPoint: CGPoint(x:0, y:0), end: CGPoint(x:0, y:0))
    @EnvironmentObject var menuObservable: ArcMenuViewObservable<Item>
    @Environment(\.colorScheme) var colorScheme
    
    @State private var contentHeight: CGFloat = 0.0
    @State private var scrollOffset: CGFloat = 0.0
    @State private var currentOffset: CGFloat = 0.0
    
    var items: [Item]
    
    var backgroundColor: Color {
        colorScheme == .dark ? ArcMenuConstants.ColorCode.backgroundDarkMode : ArcMenuConstants.ColorCode.backgroundLightMode
    }
    
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
                                
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: curveStart)
                path.addQuadCurve(to: curveEnd, control: curveControlPoint)
                path.addLine(to: CGPoint(x: 0, y: height))
                
            }.fill(self.backgroundColor)
            VStack{
                ScrollView {
                    ForEach(self.items, id: \.self) { item in 
                        ArcMenuCell(curve: self.curve, item: item).environmentObject(self.menuObservable)
                    }
                    Spacer().frame(width: nil, height: 50.0)
                }.offset(x: CGFloat.zero, y: self.scrollOffset)
                    .clipped()
                    .animation(.easeInOut)
                    .gesture(DragGesture().onChanged({ self.onDragChanged($0) }))
            }
        }
    }
    
    // Credit:  https://blog.process-one.net/writing-a-custom-scroll-view-with-swiftui-in-a-chat-application/
    func onDragChanged(_ value: DragGesture.Value) {
        // Update rendered offset
        print("Start: \(value.startLocation.y)")
        print("Start: \(value.location.y)")
        self.scrollOffset = (value.location.y - value.startLocation.y)
        print("Scrolloffset: \(self.scrollOffset)")
    }
}

struct ArcMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ArcMenuView(items: [MyMenuItem(name: "Item 1")])
    }
}
