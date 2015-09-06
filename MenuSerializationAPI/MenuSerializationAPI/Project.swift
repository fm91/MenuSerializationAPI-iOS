//
//  Project.swift
//  Butt In The Chair
//
//  Created by Yosemite Retail on 6/20/15.
//  Copyright (c) 2015 Inked Voices. All rights reserved.
//

import UIKit
import CoreData

@objc(Project) class Project: NSManagedObject {
    @NSManaged var username: String
    @NSManaged var project_name: String
    @NSManaged var data1:String
    @NSManaged var data2: String
   //you can have other attributes here

    
    
}
