//
//  File.swift
//  Kune's Journey
//
//  Created by Jarvis on 24/04/22.
//

import Foundation
import SpriteKit

struct PhyCategories {
    static let none      : UInt32 = 0
    static let all       : UInt32 = UInt32.max
    static let player    : UInt32 = 0b1
    static let stone  : UInt32 = 0b10
}
class Scene3: SKScene{

    private var kune : SKSpriteNode?
    private var isMoving = false
    private var isTouching = false
    private var points = 0
    private let theme = SKAudioNode(fileNamed: "kunegeyser.mp3")
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self

        theme.autoplayLooped = true
        
        let wait = SKAction.wait(forDuration: 3)
        self.kune = self.childNode(withName: "kune") as? SKSpriteNode
        self.kune?.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "game"), size: CGSize(width: 3018, height: 3464))
        self.kune?.physicsBody?.affectedByGravity = false
        self.kune?.physicsBody?.categoryBitMask = PhyCategories.player
        self.kune?.physicsBody?.collisionBitMask = PhyCategories.none
        self.run(SKAction.sequence([wait,SKAction.run {
            self.theme.run(SKAction.play())
            self.addChild(self.theme)
            self.isMoving = true
            self.start()
        }]))
        let wait60 = SKAction.wait(forDuration: 60)
        self.run(SKAction.sequence([wait60,SKAction.run {
            self.removeAllActions()
            self.theme.run(SKAction.changeVolume(to: 0, duration: 2))
            self.kune?.run(SKAction.moveTo(y: 6268, duration: 2))
            self.isMoving = false
            self.run(SKAction.sequence([SKAction.wait(forDuration: 2),SKAction.run {
                let scene = Scene4(fileNamed: "Scene4")
                scene?.scaleMode = .aspectFit
                self.view?.presentScene(scene!, transition: SKTransition.fade(with: UIColor.white, duration: 2))
            }]))
        }]))
    }
    func start(){
        let wait = SKAction.wait(forDuration: 1)
        let spawn = SKAction.run {
            self.spawn()
        }
        let cycle = SKAction.repeatForever(SKAction.sequence([spawn,wait]))
        self.run(cycle)
    }
    
    func spawn(){
        let positions = [CGPoint(x: -5000, y: 6268),CGPoint(x: -2560, y: 6268),CGPoint(x: 0, y: 6268),CGPoint(x: 2560, y: 6268),CGPoint(x: 5000, y: 6268)]
        let body = SKPhysicsBody(circleOfRadius: 570)
        body.affectedByGravity = true
        body.allowsRotation = true
        body.contactTestBitMask = PhyCategories.player
        body.categoryBitMask = PhyCategories.stone
        let spawn = SKSpriteNode(imageNamed: "stone")
        spawn.size = CGSize(width: 1138, height: 963)
        spawn.physicsBody = body
        spawn.position = positions[Int.random(in: 0...4)]
        self.addChild(spawn)
        spawn.run(SKAction.sequence([SKAction.wait(forDuration: 3), SKAction.removeFromParent(),SKAction.run {
            self.points += 1
            if self.points == 8{
                self.removeAllActions()
                self.theme.run(SKAction.changeVolume(to: 0, duration: 2))
                self.isMoving = false
                self.kune?.run(SKAction.moveTo(y: 6268, duration: 2))
                self.run(SKAction.sequence([SKAction.wait(forDuration: 2),SKAction.run {
                    let scene = Scene4(fileNamed: "Scene4")
                    scene?.scaleMode = .aspectFit
                    self.view?.presentScene(scene!, transition: SKTransition.fade(with: UIColor.white, duration: 2))
                }]))
            }
        }]))
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode {
                if node.name == "kune"{
                    self.isTouching = true
                }
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if (isMoving && isTouching){
                self.kune?.position.x = location.x
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isTouching = false
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isTouching = false
    }
}
extension Scene3 : SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        
        let firstBody: SKPhysicsBody = contact.bodyA
        let secondBody: SKPhysicsBody = contact.bodyB
        
        if let node = firstBody.node, node.physicsBody?.categoryBitMask ==  PhyCategories.stone{
            let fadein = SKAction.fadeIn(withDuration: 0.2)
            let fadeout = SKAction.fadeOut(withDuration: 0.2)
            let sequence = SKAction.sequence([fadeout,fadein])
            self.kune?.run(SKAction.repeat(sequence, count: 3))
            node.removeFromParent()
        }
        if let node = secondBody.node, node.physicsBody?.categoryBitMask ==  PhyCategories.stone{
            let fadein = SKAction.fadeIn(withDuration: 0.2)
            let fadeout = SKAction.fadeOut(withDuration: 0.2)
            let sequence = SKAction.sequence([fadeout,fadein])
            self.kune?.run(SKAction.repeat(sequence, count: 3))
            node.removeFromParent()
        }
    }
    
}
