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
            
            var generatedNumbersArray = [Int]()
            var generatedCardsArray = [Card]()
            
            while generatedNumbersArray.count < 8 {
                
                let randomNumber = arc4random_uniform(13) + 1
                
                //Ensure that the random number is not previously generated
                if generatedNumbersArray.contains(Int(randomNumber)) == false{
                    
                    print(randomNumber)
                    
                    // Store the number into generatedNumersArray
                    generatedNumbersArray.append(Int(randomNumber))
                    
                    let cardOne = Card()
                    cardOne.imageName = "card\(randomNumber)"
                    
                    generatedCardsArray.append(cardOne)
                    
                    let cardTwo = Card()
                    cardTwo.imageName = "card\(randomNumber)"
                    
                    generatedCardsArray.append(cardTwo)
                    
                }
                
                
            }
            
            //Shuffle the cards
            generatedCardsArray = generatedCardsArray.shuffled()
            
            return generatedCardsArray
        }
    }
