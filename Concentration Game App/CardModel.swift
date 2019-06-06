//
//  CardModel.swift
//  Concentration Game App
//
//  Created by Deshpande, Anup on 6/6/19.
//  Copyright © 2019 Deshpande, Anup. All rights reserved.
//

import Foundation

class CardModel{
    
    func getCards() -> [Card]{
        var generatedCardsArray = [Card]()
        
        for _ in 1...8{
        
        let randomNumber = arc4random_uniform(13) + 1
        print(randomNumber)
        
        let cardOne = Card()
        cardOne.imageName = "card\(randomNumber)"
        
        generatedCardsArray.append(cardOne)
        
        let cardTwo = Card()
        cardTwo.imageName = "card\(randomNumber)"
        
        generatedCardsArray.append(cardTwo)
        
        }
        
        return generatedCardsArray
    }
}
