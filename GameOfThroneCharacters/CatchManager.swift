//
//  CatchManager.swift
//  GameOfThroneCharacters
//
//  Created by Duc Dang on 7/21/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import Foundation

class CachManager {
    
    static var imageDictionary = [String:Data]()
    
    static func saveData(_ url:String, _ imageData:Data) {
        // Save the image data along with the URL
        imageDictionary[url] = imageData
        
        // return optional Data: -> Data?
    }
    
    static func retrieveData(_ url:String) -> Data? {
        // Return the saved image data or nil
        return imageDictionary[url]
    }
}
