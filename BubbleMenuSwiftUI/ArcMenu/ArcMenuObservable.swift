//
//  ArcMenuObservable.swift
//  BubbleMenuSwiftUI
//
//  Created by Ben Schultz on 12/31/19.
//  Copyright © 2019 com.concordbusinessservicesllc. All rights reserved.
//

import Foundation
class ArcMenuViewObservable<Item>: ObservableObject {
    @Published var menuItemSelected: Item?
}
