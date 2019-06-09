//
//  ViewController.swift
//  Concentration Game App
//
//  Created by Deshpande, Anup on 6/6/19.
//  Copyright © 2019 Deshpande, Anup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    var secondFlippedCard:IndexPath?
    
    var timer:Timer?
    var milliSeconds:Float = 30 * 1000 //30 seconds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        cardArray = model.getCards()
        
        //Create Timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        
        //Timer should not stop because of user scroll
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SoundManager.playSound(.shuffle)
    }
    
    
    
    //MARK: Timer Methods
    @objc func timerElapsed(){
        milliSeconds -= 2
        
        // Convert to seconds
        let seconds = String(format: "%.2f", milliSeconds/1000)
        
        timerLabel.text = "Time Remaining : \(seconds)"
        
        // When timer reaches Zero
        if milliSeconds <= 0{
            timer?.invalidate()
            timerLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            
            
            // Check if there are any cards unmatched
            checkGameEnded()
            
        }
    }
    
    
    func checkGameEnded(){
        // Check if there are any cards unmatched
        
        var isWon = true
        
        for card in cardArray{
            if card.isMatched == false{
                isWon = false
                break
            }
        }
        
        //Messaging variables
        var title = ""
        var message = ""
        
        // If not, User has won
        if isWon == true{
           
            if milliSeconds > 0{
                timer?.invalidate()
            }
            
            title = "Congratulations"
            message = "You've Won"
            
            
        }else{
            
            // If there are unmatched cards, Check if there's any time left
            if milliSeconds > 0{
                return
            }
            
            title = "Game Over"
            message = "You've Lost"
            
            
        }
        
        // Show Won/Lost message
        showAlert(title, message)
    }
    
    func showAlert(_ title:String, _ message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}


extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        let card = cardArray[indexPath.row]
        
        //check if there's any time left
        if milliSeconds <= 0{
            return
        }
        
        if card.isFlipped == false && card.isMatched == false{
            
            //Flip the card
            cell.flip()
            
            // Play the flip sound
            SoundManager.playSound(.flip)
            
            card.isFlipped = true
            
            //Determine if it's the first flipped card or second
            if firstFlippedCardIndex == nil{
                firstFlippedCardIndex = indexPath
            }else{
                
                //This is the second card being flipped
                
                //perform matching logic
                checkForMatches(indexPath)
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
            
            // Play sound
            SoundManager.playSound(.match)
            
            //Remove the cards from the grid
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            
            // Check if there are any cards left unmatched
            checkGameEnded()
        }else{
            
            //It's not a match
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            // Play the sound
            SoundManager.playSound(.nomatch)
            
            //Flip both cards back
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        
        if cardOneCell == nil{
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
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
