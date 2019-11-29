//
//  GameScene.swift
//  push me2
//
//  Created by daniel.d4 on 05/09/2018.
//  Copyright © 2018 daniel.d4. All rights reserved.
//

import SpriteKit
import UIKit


struct PhysicsCatagory {
    static let Player:UInt32 = 0b1 //2
    static let Obstacle:UInt32 = 0b10 //4
    static let coin:UInt32 = 0b100 //1
    
}


  var gameScore = 0




class GameScene: SKScene, SKPhysicsContactDelegate, UIAdaptivePresentationControllerDelegate{
    
    
    
   
    let player = SKSpriteNode(imageNamed:"turtel2")
    let player2 = SKSpriteNode(imageNamed: "turtel2")
    let obstacle = SKSpriteNode(imageNamed: "maya-wall")
    let coin = SKSpriteNode(imageNamed: "maya-coin2")
    let scoreLabel = SKLabelNode(fontNamed: "Papyrus")
    let gameOverLabe = SKLabelNode(fontNamed: "Full-TiltBoogieNF")
    let pressToSplit = SKLabelNode(fontNamed: "Papyrus")
    
    
    
    var initalPlayerPosition:CGPoint!
    var viewController: UIViewController?
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let maximumPossibleForce = touch.maximumPossibleForce
            let force = touch.force
            let normalizedForce = force/maximumPossibleForce
            
            player.position.x = (self.size.width / 2) - normalizedForce * (self.size.width/2 - 25)
            player2.position.x = (self.size.width / 2) + normalizedForce * (self.size.width/2 - 25)
            
            
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetPlayerPosition()
        
    }
    
    func resetPlayerPosition() {
        player.position = initalPlayerPosition
        player2.position = initalPlayerPosition
    }
    
    
    
    override func didMove(to view: SKView) {
        
        
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        addPlayer()
        
        
        gameScore = 0
        
    }
   
        
        
        
        
    func addScore(){
        
        gameScore += 1
        scoreLabel.text = "Gold: \(gameScore)"
        
            
        }
    
    
    func addRandomRow () {
        let randomNumber = Int(arc4random_uniform(6))
        
        addRow(type: RowType(rawValue: randomNumber)!)
    }
    
    var lastUpdateTimeInterval = TimeInterval()
    var lastYieldTimeInterval = TimeInterval()
    
    
    func updateWithTimeSinceLastUpdate (timeSinceLastUpdate:CFTimeInterval) {
        lastYieldTimeInterval += timeSinceLastUpdate
        if lastYieldTimeInterval > 0.6 {
            lastYieldTimeInterval = 0
            addRandomRow()
        }
    }
    
    
    override func update(_ currentTime: CFTimeInterval) {
        
        var timeSinceLastUpdate = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        if timeSinceLastUpdate > 1 {
            timeSinceLastUpdate = 1/60
            lastUpdateTimeInterval = currentTime
        }
        
        updateWithTimeSinceLastUpdate(timeSinceLastUpdate: timeSinceLastUpdate)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyB.node?.name == "OBSTACLE" {
            showGameOver()
            
            
        }
        if contact.bodyB.node?.name == "COIN" {
           contact.bodyB.node?.removeFromParent()
            addScore()
        }
      
    }
                
    func ToGameOver(){
        self.viewController?.performSegue(withIdentifier: "togameover", sender: nil)

    }
    
            
    func showGameOver () {
        
        let transition = SKTransition.fade(withDuration: 0.5)
        let gameOverScene = GameOverScene(size: self.size)
        
        self.view?.presentScene(gameOverScene, transition: transition)
    }
    
  
    
        
    
        
        
        
     
        
        

    
    
    
    
    
    
    
    
    
    
    
    
    
    


}


