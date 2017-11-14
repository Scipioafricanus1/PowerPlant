//
//  FirebaseHelper.swift
//  PowerPlant
//
//  Created by Ubicomp7 on 11/14/17.
//  Copyright © 2017 PowerPlantTeam. All rights reserved.
//



import UIKit
import FirebaseDatabase


class FirebaseHelper: NSObject {
    
    func getDataAsArray<T> (ref: DatabaseReference, typeOf: [T], completion: @escaping ([T]) -> Void) {
        var array = [T]()
        ref.observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                array.append(Plant(snap: child as! DataSnapshot) as! T)
            }
            completion(array)
        }
        
        
        
    }
    
    func getAllPlants(completion: @escaping ([Plant]) -> Void) {
        let plantsRef = Database.database().reference().child("Plants")
        getDataAsArray(ref: plantsRef, typeOf: [Plant](), completion: { array in
            completion(array)
        })
    }
    
    
}





