//
//  MyMenuItemView.swift
//  BubbleMenuSwiftUI
//
//  Created by Ben Schultz on 12/31/19.
//  Copyright © 2019 com.concordbusinessservicesllc. All rights reserved.
//

import SwiftUI

typealias ArcMenuViewItemView = MyMenuItemView

struct MyMenuItemView: View {
    
    @EnvironmentObject var menuObservable: ArcMenuViewObservable<MyMenuItem>
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.colorScheme) var colorScheme
    
    var item: MyMenuItem
    
    var textColor: Color {
        colorScheme == .dark  || menuObservable.menuItemSelected == item ? Color.white : Color.black
    }
       
    var body: some View {
        Button (action: {
            withAnimation(.linear(duration: ArcMenuConstants.transitionAnimationDuration)) {

                print ("tapped \(self.item.name)")
                self.menuObservable.menuItemSelected = self.item
                self.menuObservable.showMenu = self.horizontalSizeClass == .regular
                self.menuObservable.menuXOffset = 0
            }
        }) {
            Text(self.item.name)
            .font(.caption)
            .foregroundColor(textColor)
            .padding(.leading, 7).padding(.top, 5)
        }
    }
}

struct MyMenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        MyMenuItemView(item: MyMenuItem(name: "Item A"))
    }
}
