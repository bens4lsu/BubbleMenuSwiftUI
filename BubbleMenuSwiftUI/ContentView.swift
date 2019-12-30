//
//  ContentView.swift
//  BubbleMenuSwiftUI
//
//  Created by Ben Schultz on 12/30/19.
//  Copyright © 2019 com.concordbusinessservicesllc. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var menuItems = [MyMenuItem(name: "Item 1"),
                     MyMenuItem(name: "Item A"),
                     MyMenuItem(name: "Item #"),
                     MyMenuItem(name: "Item 4"),
                     MyMenuItem(name: "Item p"),
                     MyMenuItem(name: "Item т"),
                     MyMenuItem(name: "Item ⏰"),
                     MyMenuItem(name: "Item 🐶"),
                     MyMenuItem(name: "Item X")]
    
    var body: some View {
        ZStack {
            ArcMenuView(items: menuItems)
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
