//
//  ViewController.swift
//  GameOfThroneCharacters
//
//  Created by Duc Dang on 7/21/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import UIKit
import CoreData

class CharacterViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak public var collectionView: UICollectionView!
    
    var characterModel: CharacterModel!
    var collectionViewDataSourse : CharacterViewControllerTableDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Characters"
        self.characterModel = CharacterModel(self)
        self.collectionViewDataSourse = CharacterViewControllerTableDataSource(self.characterModel)
        
        self.collectionView.dataSource = self.collectionViewDataSourse
        self.collectionView.delegate = self

        self.characterModel.getCharacter()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "gotoDetail", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let dest = segue.destination as? DetailsViewController, let index = collectionView.indexPathsForSelectedItems?.first {
            dest.characterName = characterModel.character(atIndex: index.row).characterName
            
            dest.nickname = characterModel.character(atIndex: index.row).nickname
            
            dest.actorName = characterModel.character(atIndex: index.row).actorName
            
            dest.actorLink = characterModel.character(atIndex: index.row).actorLink
            
            dest.houseName = characterModel.character(atIndex: index.row).houseName
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
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



