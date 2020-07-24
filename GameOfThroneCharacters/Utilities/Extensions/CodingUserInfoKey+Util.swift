//
//  CodingCharacterInfoKey+Util.swift
//  GameOfThroneCharacters
//
//  Created by Duc Dang on 7/24/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import Foundation

public extension CodingUserInfoKey {
    // Helper property to retrieve the Core Data object context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
