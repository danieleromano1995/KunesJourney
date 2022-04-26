//
//  File.swift
//  Kune's Journey
//
//  Created by Jarvis on 24/04/22.
//

import Foundation
import SpriteKit

class Scene4: SKScene{
    private let theme = SKAudioNode(fileNamed: "endingtheme3.mp3")
    override func didMove(to view: SKView) {
        self.theme.autoplayLooped = true
        self.theme.run(SKAction.play())
        addChild(theme)
    }
    
}
