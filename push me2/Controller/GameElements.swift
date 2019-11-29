//
//  GameElements.swift
//  PushMe
//
//  Created by Training on 17/06/16.
//  Copyright © 2016 Training. All rights reserved.
//

import SpriteKit

struct CollisionBitMask {
    static let Player:UInt32 = 0x00
    static let Obstacle:UInt32 = 0x01
    static let coin:UInt32 = 0x01
    
}

enum ObstacleType:Int {
    case Small = 0
    case Medium = 1
    case Large = 2
}

enum RowType:Int {
    case oneS = 0
    case oneM = 1
    case oneL = 2
    case twoS = 3
    case twoM = 4
    case threeS = 5
}

enum Cointype:Int {
    case Small = 1
    case Medium = 2
    case Large = 3
}



extension GameScene {
    
    
 
    
    func addPlayer() {
        
        player.setScale(0.40)
        
        player.position = CGPoint(x: self.size.width / 2, y: 500)
        player.name = "PLAYER"
        player.physicsBody?.isDynamic = false
        player.physicsBody = SKPhysicsBody(rectangleOf : player.size)
        player.physicsBody?.categoryBitMask = CollisionBitMask.Player
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.contactTestBitMask = CollisionBitMask.Obstacle
        
        
        player2.setScale(0.40)
        player2.position = CGPoint(x: self.size.width / 2, y: 500)
        player2.name = "PLAYER"
        player2.physicsBody?.isDynamic = false
        player2.physicsBody = SKPhysicsBody(rectangleOf: player2.size)
        player2.physicsBody?.categoryBitMask = CollisionBitMask.Player
        player2.physicsBody?.collisionBitMask = 0
        player2.physicsBody?.contactTestBitMask = CollisionBitMask.Obstacle
        
        addChild(player)
        addChild(player2)
        
        initalPlayerPosition = player.position
        
        
        scoreLabel.text = "Gold: 0"
        scoreLabel.fontSize = 80
        scoreLabel.fontColor = SKColor.white
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.position = CGPoint(x: self.size.width*0.10, y:  self.size.height/20 + pressToSplit.frame.size.height)
        scoreLabel.zPosition = 100
        self.addChild(scoreLabel)
        
        pressToSplit.text = "PRESS TO SPLIT"
        pressToSplit.fontSize = 30
        pressToSplit.fontColor = SKColor.white
        pressToSplit.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        pressToSplit.position = CGPoint(x: self.size.width*0.50, y: self.size.height/14 + pressToSplit.frame.size.height)
        pressToSplit.zPosition = 100
        self.addChild(pressToSplit)
        
        
       
    }
    
    func addCoin (type:Cointype) -> SKSpriteNode {
        let coin = SKSpriteNode(imageNamed: "maya-coin2")
        
        coin.name = "COIN"
        coin.physicsBody?.isDynamic = true
        coin.setScale(0.3)
        coin.position = CGPoint(x: 0, y: self.size.height + coin.size.height)
        coin.physicsBody = SKPhysicsBody(rectangleOf: coin.size)
        coin.physicsBody?.categoryBitMask = CollisionBitMask.coin
        coin.physicsBody?.collisionBitMask = 0
        
        return coin
    }
    func addObstacle (type:ObstacleType) -> SKSpriteNode {
        let obstacle = SKSpriteNode(imageNamed: "maya-wall")
        
        obstacle.name = "OBSTACLE"
        obstacle.physicsBody?.isDynamic = true
        
        switch type {
        case .Small:
            obstacle.size.width = self.size.width * 0.2
            break
        case .Medium:
            obstacle.size.width = self.size.width * 0.35
            break
        case .Large:
            obstacle.size.width = self.size.width * 0.70
            break
            
        }
        
        obstacle.position = CGPoint(x: 0, y: self.size.height + obstacle.size.height)
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
        obstacle.physicsBody?.categoryBitMask = CollisionBitMask.Obstacle
        obstacle.physicsBody?.collisionBitMask = 0
        
        
        return obstacle
        
    }
    
    
    func addMovement (obstacle:SKSpriteNode) {
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: obstacle.position.x, y: -obstacle.size.height), duration: TimeInterval(3)))
        actionArray.append(SKAction.removeFromParent())
        
        obstacle.run(SKAction.sequence(actionArray))
    }
    
    func addMovement (coin:SKSpriteNode) {
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: coin.position.x, y: -coin.size.height), duration: TimeInterval(3)))
        actionArray.append(SKAction.removeFromParent())
        
        coin.run(SKAction.sequence(actionArray))
    }
    
    
    
    func addRow (type:RowType) {
        switch type {
        case .oneS:
            
            let coin1 = addCoin(type: .Small)
            let coin2 = addCoin(type: .Small)
            coin1.position = CGPoint(x: coin1.size.width + 10, y: coin1.position.y)
            coin2.position = CGPoint(x: self.size.width - coin2.size.width - 10, y: coin1.position.y)
            addMovement(coin: coin1)
            addMovement(coin: coin2)
            addChild(coin1)
            addChild(coin2)
            
            let obst = addObstacle(type: .Small)
            obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
            addMovement(obstacle: obst)
            addChild(obst)
            break
        case .oneM:
            
            let coin1 = addCoin(type: .Small)
            let coin2 = addCoin(type: .Small)
            coin1.position = CGPoint(x: coin1.size.width + 210, y: coin1.position.y)
            coin2.position = CGPoint(x: self.size.width - coin2.size.width - 210, y: coin1.position.y)
            addMovement(coin: coin1)
            addMovement(coin: coin2)
            addChild(coin1)
            addChild(coin2)
            
            let obst = addObstacle(type: .Medium)
            obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
            addMovement(obstacle: obst)
            addChild(obst)
            break
        case .oneL:
            let obst = addObstacle(type: .Large)
            obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
            addMovement(obstacle: obst)
            addChild(obst)
            break
        case .twoS:
            
            
            let obst1 = addObstacle(type: .Small)
            let obst2 = addObstacle(type: .Small)
            
            obst1.position = CGPoint(x: obst1.size.width + 50, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width - obst2.size.width - 50, y: obst1.position.y)
            
            addMovement(obstacle: obst1)
            addMovement(obstacle: obst2)
            
            addChild(obst1)
            addChild(obst2)
            
            break
        case .twoM:
            
            
            let obst1 = addObstacle(type: .Medium)
            let obst2 = addObstacle(type: .Medium)
            
            obst1.position = CGPoint(x: obst1.size.width / 2 + 50, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width - obst2.size.width / 2 - 50, y: obst1.position.y)
            
            addMovement(obstacle: obst1)
            addMovement(obstacle: obst2)
            
            
            addChild(obst1)
            addChild(obst2)
            
            break
        case .threeS:
            
            let coin1 = addCoin(type: .Small)
            let coin2 = addCoin(type: .Small)
            coin1.position = CGPoint(x: coin1.size.width + 290, y: coin1.position.y)
            coin2.position = CGPoint(x: self.size.width - coin2.size.width - 290, y: coin1.position.y)
            addMovement(coin: coin1)
            addMovement(coin: coin2)
            addChild(coin1)
            addChild(coin2)
            
            
            let obst1 = addObstacle(type: .Small)
            let obst2 = addObstacle(type: .Small)
            let obst3 = addObstacle(type: .Small)
            
            obst1.position = CGPoint(x: obst1.size.width / 2 + 50, y: obst1.position.y) // Left
            obst2.position = CGPoint(x: self.size.width - obst2.size.width / 2 - 50, y: obst1.position.y) // Right
            obst3.position = CGPoint(x: self.size.width / 2, y: obst1.position.y) // Center
            
            
            addMovement(obstacle: obst1)
            addMovement(obstacle: obst2)
            addMovement(obstacle: obst3)
            
            addChild(obst1)
            addChild(obst2)
            addChild(obst3)
            
            break
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

