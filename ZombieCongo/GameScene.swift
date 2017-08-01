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
    
    let zombie = SKSpriteNode(imageNamed: "zombie1")

    override func didMove(to view: SKView) {
        let backgroud = SKSpriteNode(imageNamed: "background1")
        backgroud.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroud.anchorPoint = CGPoint(x: 0.5, y: 0.5) // default
        backgroud.zPosition = -1
        addChild(backgroud)
        
        zombie.position = CGPoint(x: 400, y: 400)
        addChild(zombie)
    }
}
