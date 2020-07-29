//
//  Character.swift
//  GameOfThroneCharacters
//
//  Created by Duc Dang on 7/24/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import UIKit
import CoreData

class Character : NSManagedObject, Codable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest<Character>(entityName: "Character")
    }
    
    @NSManaged public var characterName: String?
    @NSManaged public var houseName: String?
    @NSManaged public var characterImageFull: String?
    @NSManaged public var actorName: String?
    @NSManaged public var actorLink: String?
    @NSManaged public var nickname: String?
    
    enum CodingKeys: String, CodingKey {
        case characterName = "characterName"
        case houseName = "houseName"
        case characterImageFull = "characterImageFull"
        case actorName = "actorName"
        case actorLink = "actorLink"
        case nickname = "nickname"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
        let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Character", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        characterName = try container.decode(String.self, forKey: .characterName)
        houseName = try container.decodeIfPresent(String.self, forKey: .houseName)
        characterImageFull = try container.decodeIfPresent(String.self, forKey: .characterImageFull)
        actorName = try container.decodeIfPresent(String.self, forKey: .actorName)
        actorLink = try container.decodeIfPresent(String.self, forKey: .actorLink)
        nickname = try container.decodeIfPresent(String.self, forKey: .nickname)
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(characterName, forKey: .characterName)
        try container.encode(houseName, forKey: .houseName)
        try container.encode(characterImageFull, forKey: .characterImageFull)
        try container.encode(actorName, forKey: .actorName)
        try container.encode(actorLink, forKey: .actorLink)
        try container.encode(nickname, forKey: .nickname)
        
    }
}
