//
//  File.swift
//  Kune's Journey
//
//  Created by Jarvis on 24/04/22.
//

import Foundation
import SpriteKit

class Scene2: SKScene{
    override func didMove(to view: SKView) {
        let wait = SKAction.wait(forDuration: 9.5)
        let scene = Scene3(fileNamed: "Scene3")
        scene?.scaleMode = .aspectFit
        self.run(SKAction.sequence([wait,SKAction.run {
            self.view?.presentScene(scene!, transition: SKTransition.fade(with: UIColor.white, duration: 1))
        }]))
    }
}
