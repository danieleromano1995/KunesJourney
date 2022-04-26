//
//  File.swift
//  Kune's Journey
//
//  Created by Jarvis on 24/04/22.
//

import Foundation
import SpriteKit

class Scene1: SKScene{
    private var cam : SKCameraNode?
    private let theme = SKAudioNode(fileNamed: "endingtheme3.mp3")

    override func didMove(to view: SKView) {
            
        self.theme.autoplayLooped = true
        self.theme.run(SKAction.play())
        addChild(theme)
        self.cam = self.childNode(withName: "cam") as? SKCameraNode
        self.camera = cam
        let wait = SKAction.wait(forDuration: 30)
        self.run(SKAction.sequence([wait,SKAction.run {
            let scene = Scene2(fileNamed: "Scene2")
            scene?.scaleMode = .aspectFit
            self.view?.presentScene(scene!, transition: SKTransition.fade(with: UIColor.white, duration: 3))
        }]))
    }
}
