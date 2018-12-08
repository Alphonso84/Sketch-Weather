//
//  GameScene.swift
//  Sketch Weather
//
//  Created by user on 12/7/18.
//  Copyright © 2018 Alphonso. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        addEmitter()
    }
    
    func addEmitter() {
        
        let emitter = SKEmitterNode(fileNamed: Emitter.rain)!
        emitter.zPosition = 1000
        emitter.position = CGPoint(x: size.width / 2, y: size.height)
        addChild(emitter)
        
    }

}
