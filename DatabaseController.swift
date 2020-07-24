//
//  DatabaseController.swift
//  GameOfThroneCharacters
//
//  Created by Duc Dang on 7/23/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import Foundation
import CoreData

class DatabaseController {
    private init() {}
    
    
    
    class func getContext () -> NSManagedObjectContext {
        return persistenceContainer.viewContext
    }
    
    class func getAllCharacters() -> Array<Character> {
        let all = NSFetchRequest<Character>(entityName: "Character")
        var allCharacters = [Character]()
        do{
            let fetched = try DatabaseController.getContext().fetch(all)
            allCharacters = fetched
        } catch {
            
        }
    }
}
