//
//  ViewController.swift
//  GameOfThroneCharacters
//
//  Created by Duc Dang on 7/21/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import UIKit
import CoreData

class CharacterViewController: UIViewController {
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    //    let context = UIApplication.shared.delegate as!
    //    var model = CharacterModel()
    //    var characters = [Character]()
    //
    //    private var searchData: [Character]! = []
    //    private var savedData: [Character]! = []
    
    // Core Data proprety
    
    var characterModel: CharacterModel!
    var collectionViewDataSourse : CharacterViewControllerTableDataSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Characters"
        self.characterModel = CharacterModel(self)
        self.collectionViewDataSourse = CharacterViewControllerTableDataSource(self.characterModel)
        
        self.collectionView.dataSource = self.collectionViewDataSourse
        self.collectionView.delegate = self.collectionViewDataSourse
        
        self.characterModel.getCharacter()
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
        
         
     }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            //        if let dest = segue.destination as? DetailsViewController, let index = collectionView.indexPathsForSelectedItems?.first {
            //
            //            dest.characterName = characters[index.row].characterName as Any
            //
            //            dest.nickname = characters[index.row].nickname ?? "Character has no Nickname" as Any
            //
            //            dest.actorName = characters[index.row].actorName as Any
            //            dest.houseName = characters[index.row].houseName as Any
            //            dest.actorLink =  characters[index.row].actorLink
            //        }
    }
}


extension CharacterViewController : UISearchBarDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBar", for: indexPath)
        return searchView
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //        self.searchData.removeAll()
        //
        //        for item in self.savedData {
        //            if (item.characterName?.lowercased().contains(searchBar.text!.lowercased()))! {
        //                self.searchData.append(item)
        //                self.characters = self.searchData
        //            } else if(searchBar.text!.isEmpty) {
        //                self.characters  = self.savedData
        //            }
        //        }
        //
        //        self.collectionView.reloadData()
    }
    
}

extension CharacterViewController: CharacterModelProtocol {
    func parseCharactersSuccess() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func parseCharactersFailedWithMessage(_ message: String) {
        self.showError(nil, message: message)
    }
    
    
}



