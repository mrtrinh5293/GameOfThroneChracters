//
//  CharacterViewModel.swift
//  GameOfThroneCharacters
//
//  Created by Duc Dang on 7/24/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import UIKit

class CharacterViewModel: NSObject {

    private var character: Character
    
    init(_ character: Character) {
        self.character = character
    }
    
    var characterName: String {
        get {
            return self.character.characterName!
        }
    }
    
    var houseName: String {
        get {
            return self.character.houseName ?? "Character has no house name"
        }
    }
    
    var characterImageFull: String {
        get {
            return self.character.characterImageFull ??  ""
        }
    }
    
    var actorName: String {
        get {
            return self.character.actorName!
        }
    }
    
    var actorLink: String {
        get {
            return self.character.actorLink!
        }
    }
    
    
    var nickname: String {
        get {
            return self.character.nickname ?? "Character has no nickname" 
        }
    }
    
}
