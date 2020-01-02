//
//  MenuCell.swift
//  BubbleMenuSwiftUI
//
//  Created by Ben Schultz on 11/13/19.
//  Copyright © 2019 com.concordbusinessservicesllc. All rights reserved.
//

import SwiftUI

enum ArcMenuCellError: Error {
    case percentageOutOfRange
}

struct ArcMenuCell<Item: ArcMenuViewItem>: View {
    
    @EnvironmentObject var menuObservable: ArcMenuViewObservable<Item>
    @Environment(\.colorScheme) var colorScheme
        
    var curve: ArcMenuCurve
    var item: Item
    
    var backgroundColor: Color {
        if menuObservable.menuItemSelected == item {
            return colorScheme == .dark ? ArcMenuConstants.ColorCode.cellBGSelectedDarkMode : ArcMenuConstants.ColorCode.cellBGSelectedLightMode
        }
        else {
            return colorScheme == .dark ? ArcMenuConstants.ColorCode.cellBGDarkMode : ArcMenuConstants.ColorCode.cellBGLightMode
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                //var width = geometry.size.width
                let height = max(min(geometry.size.height, ArcMenuConstants.Cell.maxHeight), ArcMenuConstants.Cell.minHeight)
                let y = geometry.frame(in: .global).midY
                let curveHeight = self.curve.end.y - self.curve.start.y
                let percentOfCurve = y / curveHeight
                do {
                    let width = try self.extrapolateDimensionOverQuadCurve (fromPercent: percentOfCurve, start: self.curve.start.x, controlPoint: self.curve.controlPoint.x, end: self.curve.end.x)
                                
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: width * ArcMenuConstants.Cell.widthFactor, y: 0))
                    path.addQuadCurve(to: CGPoint(x: width * ArcMenuConstants.Cell.widthFactor, y: height),
                                      control: CGPoint(x: width * (ArcMenuConstants.Cell.widthFactor + ArcMenuConstants.Cell.bulgeFactor), y: height * 0.5))
                    path.addLine(to: CGPoint(x: 0, y: height))
                }
                catch {
                    // cell out of range -- do nothing
                }
            }.fill(ArcMenuConstants.Cell.bgColor)
            ArcMenuViewItemView(item: self.item).environmentObject(self.menuObservable)
        }.padding(.bottom, ArcMenuConstants.Cell.bottomPadding)
         .padding(.top, ArcMenuConstants.Cell.topPadding)
    }
    
    private func extrapolateDimensionOverQuadCurve(fromPercent t: CGFloat, start: CGFloat, controlPoint c1: CGFloat, end: CGFloat ) throws -> CGFloat {
        if t > 1 || t < 0 {
            throw ArcMenuCellError.percentageOutOfRange
        }
        let t_ = (1.0 - t)
        let tt_ = t_ * t_
        let tt = t * t
        
        return start * tt_
        + 2.0 * c1 * t_ * t
            + end * tt
    }
}

struct ArcMenuCell_Previews: PreviewProvider {
    static var previews: some View {
        ArcMenuCell(curve: ArcMenuCurve(start: CGPoint(x:30, y:0), controlPoint: CGPoint(x:70, y:100), end: CGPoint(x:30, y:200)), item: MyMenuItem(name: "Item 1"))
    }
}

