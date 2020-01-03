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
    var item: MyMenuItem
    
    var body: some View {
        Button (action: {
            withAnimation(.linear(duration: ArcMenuConstants.menuTransitionAnimationDuration)) {

                print ("tapped \(self.item.name)")
                self.menuObservable.menuItemSelected = self.item
                self.menuObservable.showMenu = self.horizontalSizeClass == .regular
            }
        }) {
            Text(self.item.name)
            .font(.caption)
            .foregroundColor(.white)
            .padding(.leading, 7).padding(.top, 5)
        }
    }
}

struct MyMenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        MyMenuItemView(item: MyMenuItem(name: "Item A"))
    }
}
