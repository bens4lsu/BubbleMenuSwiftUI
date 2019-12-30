//
//  Items.swift
//  BubbleMenuSwiftUI
//
//  Created by Ben Schultz on 12/28/19.
//  Copyright © 2019 com.concordbusinessservicesllc. All rights reserved.
//

import SwiftUI



class MyMenuItem: ArcMenuViewItem {
    
    var id: UUID
    var name: String
    
    init (name: String){
        self.id = UUID()
        self.name = name
    }
    
    var view: some View {
        Text(self.name)
    }
    
    // MARK:  Methods to make class conform to Hashable
    static func == (lhs: MyMenuItem, rhs: MyMenuItem) -> Bool {
        lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(id)
    }
}
