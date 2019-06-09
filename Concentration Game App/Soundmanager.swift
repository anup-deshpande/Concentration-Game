//
//  Soundmanager.swift
//  Concentration Game App
//
//  Created by Deshpande, Anup on 6/9/19.
//  Copyright © 2019 Deshpande, Anup. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager{
    
    static var audioPlayer:AVAudioPlayer?
    
    enum SoundEffect{
        
        case flip
        case shuffle
        case match
        case nomatch
    }
    
    static func playSound(_ effect:SoundEffect){
        
        var soundFileName = ""
        
        switch effect {
        case .flip:
            soundFileName = "cardflip"
            
        case .match:
            soundFileName = "dingcorrect"
            
        case .nomatch:
            soundFileName = "dingwrong"
            
        case .shuffle:
            soundFileName = "shuffle"
        }
        
        
        let bundlePath = Bundle.main.path(forResource: soundFileName, ofType: "wav")
        
        // Check if bundlePath is not nil
        guard bundlePath != nil else {
            print("Couldn't file sound file \(soundFileName) in the bundle")
            return
        }
        
        // Create a URL object from string path
        let soundURL = URL(fileURLWithPath: bundlePath!)
        
        do{
            // Create Audio Player object
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            
            // Play the sound
            audioPlayer?.play()
        }
        catch{
            
            //Error in creating Audio player object
            print("Error in creating Audio player object for sound file : \(soundFileName)")
        }
        
        
        
        
        
    }
}
