//
//  File.swift
//  Kune's Journey
//
//  Created by Jarvis on 24/04/22.
//

import Foundation
import SpriteKit

class StartGame: SKScene{
    private var start : SKLabelNode?
    private var title : SKSpriteNode?
    override func didMove(to view: SKView) {
        start = self.childNode(withName: "start") as? SKLabelNode
        title = self.childNode(withName: "title") as? SKSpriteNode
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let startFade: Void? = self.start?.run(SKAction.fadeOut(withDuration: 2))
        let titleFade: Void? = self.title?.run(SKAction.fadeOut(withDuration: 2))
        
        let fadingAll = SKAction.run {
            startFade
            titleFade
        }
        let wait = SKAction.wait(forDuration: 2)
        let changeScene = SKAction.run {
            let scene = Intro(fileNamed: "Intro")
            scene?.scaleMode = .aspectFit
            self.view?.presentScene(scene)
        }
        let sequence = SKAction.sequence([fadingAll,wait,changeScene])
        self.run(sequence)
    }
}
