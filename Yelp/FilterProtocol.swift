//
//  FilterProtocol.swift
//  Yelp
//
//  Created by Alex Choi on 9/23/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import Foundation

protocol FilterProtocol {
    var sortBy: Int {set get}
    var radius: Int {set get}
    var deals: Bool {set get}
}