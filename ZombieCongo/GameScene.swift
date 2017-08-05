//
//  GameScene.swift
//  ZombieCongo
//
//  Created by Андрей Питеров on 8/1/17.
//  Copyright © 2017 Andrew Pierov. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var lastTouchLocation: CGPoint?
    
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    
    let zombie = SKSpriteNode(imageNamed: "zombie1")
    let zombieMoviePointsPerSec: CGFloat = 480.0
    var velocity: CGPoint = CGPoint.zero

    override func didMove(to view: SKView) {
        let backgroud = SKSpriteNode(imageNamed: "background1")
        backgroud.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroud.anchorPoint = CGPoint(x: 0.5, y: 0.5) // default
        backgroud.zPosition = -1
        addChild(backgroud)
        
        zombie.position = CGPoint(x: 400, y: 400)
        addChild(zombie)
    }
    
    func moveZombieToward(_ location: CGPoint){
        let offset = CGPoint(x: location.x - zombie.position.x, y: location.y - zombie.position.y)
        let length = sqrt(Double(offset.x * offset.x + offset.y * offset.y))
        let direction = CGPoint(x: offset.x/CGFloat(length), y: offset.y/CGFloat(length))
        
        velocity = CGPoint(x: direction.x * zombieMoviePointsPerSec, y: direction.y * zombieMoviePointsPerSec)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self)
        lastTouchLocation = touchLocation
        moveZombieToward(lastTouchLocation!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let toush = touches.first else{
            return
        }
        
        let touchLocation = toush.location(in: self)
        lastTouchLocation = touchLocation
        moveZombieToward(lastTouchLocation!)
    }
    
    
    func moveSprite(_ sprite: SKSpriteNode, velosity: CGPoint){
        let amountToMove = CGPoint(x: velosity.x * CGFloat(dt),
                                  y: velosity.y * CGFloat(dt))
        print("Amount to move \(amountToMove)")
        sprite.position = CGPoint(x: sprite.position.x + amountToMove.x,
                                  y: sprite.position.y + amountToMove.y)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        }else{
           dt = 0
        }
        
        lastUpdateTime = currentTime
        print("\(dt*1000) milliseconds since last update")
        
        // moveSprite(zombie, velosity: CGPoint(x: zombieMoviePointsPerSec, y: 0))
        if let lastTouchLocation = lastTouchLocation {
            let diff = lastTouchLocation - zombie.position
            if (diff.length() <= zombieMoviePointsPerSec * CGFloat(dt)) {
                zombie.position = lastTouchLocation
                velocity = CGPoint.zero
            } else {
                moveSprite(zombie, velosity: velocity)
            }
        }
    }
}
