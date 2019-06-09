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
        
        if card.isMatched == true{
            
            //if the card is matched make images invisible
            backImageView.alpha = 0
            frontImageView.alpha = 0
            
            return
        }else{
            
            //if the card hasn't been matched make images visible
            backImageView.alpha = 1
            frontImageView.alpha = 1
            
            
        }
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
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) { //To delay execution by half a second
              UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight,.showHideTransitionViews], completion: nil)
        }
      
    }
    
    func remove(){
        //Removed matched cards from the grid
        backImageView.alpha = 0
        
        //Animate this
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            
            self.frontImageView.alpha = 0
            
        }, completion: nil)
       
    }
    
}
