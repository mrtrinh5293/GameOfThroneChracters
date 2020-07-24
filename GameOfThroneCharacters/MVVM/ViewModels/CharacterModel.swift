//
//  CharacterModel.swift
//  GameOfThroneCharacters
//
//  Created by Duc Dang on 7/24/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import Foundation
import CoreData

protocol CharacterModelProtocol: NSObject {
    //    func charactersRetrieved(_ characters:[Character])
    func parseCharactersSuccess()
    func parseCharactersFailedWithMessage(_ message: String)
    
}

class CharacterModel: NSObject {
    
    private var characters: [Character] {
        // didSet is the observer called on any property when a value is set to that property.
        didSet {
            self.delegate?.parseCharactersSuccess()
        }
        
    }
    
    weak var delegate: CharacterModelProtocol?
    
    init(_ delegate: CharacterModelProtocol?) {
        self.delegate = delegate
        self.characters = [Character]()
    }
    
        let stringUrl = "https://api.jsonbin.io/b/5f15de09c1edc466175ad86c/11"
//    let stringUrl = """
//    [
//       {
//          "characterName":"aaaa",
//          "houseName":"Ganeshji",
//          "actorLink": "hoho",
//            "actorName":"Bangalore",
//             "nickname":"Karnataka",
//             "characterImageFull":"India"
//       },
//    ]
//"""
    func getCharacter() {
    
        
//         Create url object
                let url = URL(string: stringUrl)
        
                // check that it isnt nil
                guard url != nil else {
                    print("Could not get the url object")
                    return
                }
        
                let session = URLSession.shared
//         create data task
                let dataTask = session.dataTask(with: url!) { (data, response, error) in
                    if error == nil && data != nil {
        
                        let decoder = JSONDecoder()
        
                        let managedObjectContext = CoreDataStorage.shared.managedObjectContext()
        
                        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                            fatalError("Failed to retrieve managed object context Key")
                        }
        
                        decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
        
                        do {
                            // Parse the json into ArticlesService
                            let result = try decoder.decode([Character].self, from: data!)
                            self.characters = result
                            print(result)
        
                            // Get the article
                            //                        let characters = characterService.characters!
        
                            // Pass the article to the view controller in the main thread
                            //                        DispatchQueue.main.async {
                            //                            self.delegate?.charactersRetrieved(characters)
                            //
                            //                        }
                        } catch {
                            print("Could not parse JSon, Decodable Err: \(error) ")
                        }
        
                        CoreDataStorage.shared.clearStorage(forEnity: "Character")
                        CoreDataStorage.shared.saveContext()
        
                        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
                        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                        print(paths[0])
                    }
                }
                // start the data task
                dataTask.resume()
        
       //  Parse the returned JSON into article instances and pass it back the the view controller with the protocol and delegate pattern
        
    }
    func numberOfCharacters() -> Int {
        
        return self.characters.count
    }
    
    func character(atIndex index: Int) -> CharacterViewModel {
        return CharacterViewModel(self.characters[index])
    }
}
