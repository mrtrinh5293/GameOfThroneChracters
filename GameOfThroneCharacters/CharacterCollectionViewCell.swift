//
//  CharacterCollectionViewCell.swift
//  GameOfThroneCharacters
//
//  Created by Duc Dang on 7/21/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var characterImageView: UIImageView!
    
    @IBOutlet weak var characterLabelName: UILabel!
    
    
    var charDemoDisplay: Character?
    
    
    func displayCharacterDemo(_ character: Character) {
        characterImageView.image = nil
        characterImageView.alpha = 0
        characterLabelName.text = ""
        characterLabelName.alpha = 0
        
        charDemoDisplay = character
        
        characterLabelName.text = charDemoDisplay?.characterName
        
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            [weak self] in
            self?.characterLabelName.alpha = 1
            
        })
        
        guard charDemoDisplay!.characterImageFull != nil else {
            print("Can not get the picture")
            return
        }
        
        let imageUrlString = charDemoDisplay!.characterImageFull!
        
        if let imageData = CachManager.retrieveData(imageUrlString) {
            characterImageView.image = UIImage(data: imageData)
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                [weak self] in
                self?.characterImageView.alpha = 1
            })
            return
            
        }
        
        let url = URL(string: imageUrlString)
        
        guard url != nil else {
            print("Can not get the picture")
            return
        }
        
        let session = URLSession.shared
        
        // Create a datatask
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                
                // Save the data into cache
                CachManager.saveData(imageUrlString, data!)
                
                // Check if the url string that the data task went off to download matches the article this cell is set to display
                if self.charDemoDisplay!.characterImageFull == imageUrlString {
                    DispatchQueue.main.async {
                        // Display data image
                        self.characterImageView.image = UIImage(data: data!)
                        
                        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                            [weak self] in
                            self?.characterImageView.alpha = 1
                            
                        })
                        
                    }
                }
            }
        }
        // Kick off the dataTask
        dataTask.resume()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
}
//}

