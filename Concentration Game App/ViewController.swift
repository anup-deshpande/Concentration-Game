//
//  ViewController.swift
//  Concentration Game App
//
//  Created by Deshpande, Anup on 6/6/19.
//  Copyright © 2019 Deshpande, Anup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    var secondFlippedCard:IndexPath?
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        cardArray = model.getCards()
    }
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        let card = cardArray[indexPath.row]
        
        
        if card.isFlipped == false{
            
            //Flip the card
            cell.flip()
            card.isFlipped = true
            
            //Determine if it's the first flipped card or second
            if firstFlippedCardIndex == nil{
                firstFlippedCardIndex = indexPath
            }else{
                
                //This is the second card being flipped
                //TODO:  perform matching logic
            }
            
        }
       
    }
    
    //Mark: Game Logic methods
    
    func checkForMatches(_ secondFlippedCardIndex:IndexPath){
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as?
         CardCollectionViewCell
        
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        if cardOne.imageName == cardTwo.imageName{
            
            //It's a match
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            //Remove the cards from the grid
            cardOneCell?.remove()
            cardTwoCell?.remove()
        }else{
            
            //It's not a match
            
            //Remove the cards from the grid
            
            //Flip both cards back
        }
        
        firstFlippedCardIndex = nil
    }
}


extension ViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        cardCell.setCard(cardArray[indexPath.row])
        
        return cardCell
    }
    
    
}
