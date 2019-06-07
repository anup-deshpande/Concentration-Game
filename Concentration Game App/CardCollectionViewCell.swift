//
//  CardCollectionViewCell.swift
//  Concentration Game App
//
//  Created by Deshpande, Anup on 6/6/19.
//  Copyright © 2019 Deshpande, Anup. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    
    var card: Card?
    
    func setCard(_ card:Card){
        
        self.card = card
        
        frontImageView.image = UIImage(named: card.imageName)
        
        //Determine if the card is flipped up or flipped Down
        if card.isFlipped == true{
            
             UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
            
        }else{
           UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromRight,.showHideTransitionViews], completion: nil)
        }
    }
    
    func flip(){
        //Animate card to show front view
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
    }
    
    func flipBack(){
         //Animate card to show back view
        UIView.transition(from: frontImageView, to: backImageView, duration: 0.3, options: [.transitionFlipFromRight,.showHideTransitionViews], completion: nil)
    }
    
    func remove(){
        //Removed matched cards from the grid
        backImageView.alpha = 0
        frontImageView.alpha = 0
    }
    
}
