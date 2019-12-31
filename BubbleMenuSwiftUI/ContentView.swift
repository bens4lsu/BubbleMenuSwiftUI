//
//  ContentView.swift
//  BubbleMenuSwiftUI
//
//  Created by Ben Schultz on 12/30/19.
//  Copyright © 2019 com.concordbusinessservicesllc. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var menuObservable: ArcMenuViewObservable<MyMenuItem>
    
    var menuItems = [MyMenuItem(name: "Item 1"),
                     MyMenuItem(name: "Item A"),
                     MyMenuItem(name: "Item #"),
                     MyMenuItem(name: "Item 4"),
                     MyMenuItem(name: "Item p"),
                     MyMenuItem(name: "Item т"),
                     MyMenuItem(name: "Item ⏰"),
                     MyMenuItem(name: "Item 🐶"),
                     MyMenuItem(name: "Item X")]
    
    
    
    var itemDescription: String {
        guard let item = menuObservable.menuItemSelected else {
            return "No item has been selected."
        }
        return item.description
    }
    
    var body: some View {
        GeometryReader { geometry in
            return self.layoutView(forWidth: geometry.size.width)
        }
    }
    
    private func layoutView(forWidth width: CGFloat) -> AnyView {
        if horizontalSizeClass == .compact {
            return AnyView(ZStack{
                ArcMenuView(items: menuItems).environmentObject(menuObservable)
                Text(self.itemDescription).padding(.trailing, 12)
            })
        } else {
            return AnyView(HStack{
                ArcMenuView(items: menuItems).environmentObject(menuObservable)
                Text(self.itemDescription).padding(.trailing, 12)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
