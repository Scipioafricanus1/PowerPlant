//
//  Plant.swift
//  PowerPlant
//
//  Created by Ubicomp7 on 11/14/17.
//  Copyright © 2017 PowerPlantTeam. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Plant {
    
    let key:Any
    let description:String
    let name:String
    let plantType:String
    let waterNeeds:String
    let maintenance: String
    let tips: String
    
    init(snap: DataSnapshot) {
        key = snap.key
        
        let value = snap.value as? NSDictionary
        description = value?["description"] as? String ?? ""
        name = value?["name"] as? String ?? ""
        plantType = value?["type"] as? String ?? ""
        waterNeeds = value?["waterNeeds"] as? String ?? ""
        maintenance = value?["maintenance"] as? String ?? ""
        tips = value?["tips"] as? String ?? ""
    }
    init() {
        key = ""
        description = ""
        plantType = ""
        waterNeeds = ""
        name = ""
        maintenance = ""
        tips = ""
    }
    
    
}
