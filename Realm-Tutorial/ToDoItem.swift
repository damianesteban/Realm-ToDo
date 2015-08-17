//
//  ToDoItem.swift
//  Realm-Tutorial
//
//  Created by Damian Esteban on 8/17/15.
//  Copyright (c) 2015 Damian Esteban. All rights reserved.
//

import Foundation
import Realm

class ToDoItem: RLMObject {
    dynamic var name = ""
    dynamic var finished = false
}