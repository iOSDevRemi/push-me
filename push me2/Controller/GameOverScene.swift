//
//  GameOverScene.swift
//  PushMe
//
//  Created by Training on 17/06/16.
//  Copyright © 2016 Training. All rights reserved.
//

import SpriteKit
import Lottie

class GameOverScene: SKScene {

    let restartLabel = SKLabelNode(fontNamed: "Papyrus")
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    
        
        let backgroundGameOver = SKSpriteNode(imageNamed: "abstract-ancient-antique-235986")
        backgroundGameOver.size = self.size
        backgroundGameOver.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        backgroundGameOver.zPosition = 0
        self.addChild(backgroundGameOver)
        
        
        
        let gameOverLabel = SKLabelNode(fontNamed: "Papyrus")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 120
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.position = CGPoint (x: self.size.width/2, y: self.size.height*0.80)
        gameOverLabel.zPosition = 2
        self.addChild(gameOverLabel)
        
        let scoreLabel = SKLabelNode(fontNamed: "Papyrus")
        scoreLabel.text = "score: \(gameScore)"
        scoreLabel.fontSize = 90
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.55)
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        
        
        
        let defaults = UserDefaults()
        var highScoreNumber = defaults.integer(forKey: "highScoreSaved")
        
        
        
        if gameScore > highScoreNumber {
            highScoreNumber = gameScore
            defaults.set(highScoreNumber, forKey: "highScoreSaved")
            
        }
        
        let highScoreLabel = SKLabelNode(fontNamed: "Papyrus")
        highScoreLabel.text = "High Score: \(highScoreNumber)"
        highScoreLabel.fontSize = 90
        highScoreLabel.fontColor = SKColor.white
        highScoreLabel.zPosition = 1
        highScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.45)
        self.addChild(highScoreLabel)

        
        restartLabel.text = "restart"
        
        restartLabel.fontSize = 80
        restartLabel.fontColor = SKColor.white
        restartLabel.zPosition = 1
        restartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.2)
        self.addChild(restartLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            
            
            if restartLabel.contains(pointOfTouch) {
                
                let sceneToMoveTo = GameScene (size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
}
}
}
