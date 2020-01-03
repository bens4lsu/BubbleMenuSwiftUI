//
//  ContentView.swift
//  BubbleMenuSwiftUI
//
//  Created by Ben Schultz on 11/13/19.
//  Copyright © 2019 com.concordbusinessservicesllc. All rights reserved.
//


import SwiftUI

struct ArcMenuView<Item>: View where Item:ArcMenuViewItem {
    
    @EnvironmentObject var menuObservable: ArcMenuViewObservable<Item>
    @Environment(\.colorScheme) var colorScheme
    
    @State private var contentHeight: CGFloat = 0.0
    @State private var scrollOffset: CGFloat = 0.0
    @State private var currentOffset: CGFloat = 0.0
        
    var items: [Item]
    
    var backgroundColor: Color {
        colorScheme == .dark ? ArcMenuConstants.ColorCode.backgroundDarkMode : ArcMenuConstants.ColorCode.backgroundLightMode
    }
    
    var imageOpenMenu: Image {
        colorScheme == .dark ? ArcMenuConstants.imageOpenMenuDarkMode : ArcMenuConstants.imageOpenMenuLightMode
    }
    
    var body: some View {
        Group {
            if self.menuObservable.showMenu {
                fullMenuView.transition(.move(edge: .leading))
            } else {
                hiddenMenuView.transition(.move(edge: .leading))
            }
        }
    }
    
    var fullMenuView: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                let startX = min(width * ArcMenuConstants.curveStartFactor, ArcMenuConstants.maxStartX)
                let curveStart = CGPoint(x: startX, y: 0)
                let curveControlPointX = min (width * ArcMenuConstants.curveControlPointFactor, ArcMenuConstants.maxControlPointX)
                let curveControlPoint = CGPoint(x: curveControlPointX, y: height * 0.5)
                let curveEnd = CGPoint(x: startX, y: height)
                
                // let environment know the parameters of the curve
                let curve = self.menuObservable.arcMenuCurve
                if !(curve.start == curveStart && curve.controlPoint == curveControlPoint && curve.end == curveEnd) {
                    curve.start = curveStart
                    curve.controlPoint = curveControlPoint
                    curve.end = curveEnd
                }
                
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: curveStart)
                path.addQuadCurve(to: curveEnd, control: curveControlPoint)
                path.addLine(to: CGPoint(x: 0, y: height))
                
            }.fill(self.backgroundColor)
            self.fullMenuButtons
        }.background(Color.clear)
            .offset(x: self.menuObservable.menuXOffset)
    }
    
    var fullMenuButtons: some View {
        VStack{
            ScrollView(showsIndicators: false) {
                ForEach(self.items, id: \.self) { item in
                    ArcMenuCell(curve: self.menuObservable.arcMenuCurve, item: item).environmentObject(self.menuObservable)
                }
                Spacer().frame(width: nil, height: 50.0)
            }.offset(x: CGFloat.zero, y: self.scrollOffset)
                .clipped()
                .gesture(DragGesture().onChanged({ self.onDragChanged($0) }))
        }
    }
    
    var hiddenMenuView: some View {
        GeometryReader { geometry in
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addQuadCurve(to: CGPoint(x: 0, y: geometry.size.height), control: CGPoint(x: ArcMenuConstants.hiddenMenuControlPointX, y: geometry.size.height * 0.5))
            }.fill(self.backgroundColor)
            self.hiddenMenuButton.frame(width: ArcMenuConstants.hiddenMenuControlPointX / 2, height: geometry.size.height, alignment: .center)
        }
    }
    
    var hiddenMenuButton: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: ArcMenuConstants.menuTransitionAnimationDuration)) {
                self.menuObservable.showMenu = true
            }
        }) {
            self.imageOpenMenu
        }
    }
    
    
    // Credit:  https://blog.process-one.net/writing-a-custom-scroll-view-with-swiftui-in-a-chat-application/
    func onDragChanged(_ value: DragGesture.Value) {
        // Update rendered offset
        self.scrollOffset = (value.location.y - value.startLocation.y)
    }
}

struct ArcMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ArcMenuView(items: [MyMenuItem(name: "Item 1")])
    }
}
