//
//  ViewController.swift
//  Scribe
//
//  Created by daniel.d4 on 15/04/2019.
//  Copyright © 2019 daniel.d4. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    //OUtlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var playBtn: CercleButton!
    
    
    //Variable
    var audioPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activityIndicator.stopAnimating()
        
    }


    func reguestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                    do{
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                        
                    } catch {
                        print("Erro!")
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        if let error = error {
                            print("there was an error: \(error)")
                        } else {
                            self.textView.text = result?.bestTranscription.formattedString
                        }
                    }
                    
                }
            }
        }
        
    }
    
    @IBAction func playClicked(_ sender: Any) {
        
        activityIndicator.stopAnimating()
        reguestSpeechAuth()
        
        
    }
    
    
    
}

