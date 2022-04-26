//
//  File.swift
//  Kune's Journey
//
//  Created by Jarvis on 24/04/22.
//

import Foundation
import SpriteKit

struct PhysicsCategory {
    static let none      : UInt32 = 0
    static let all       : UInt32 = UInt32.max
    static let head    : UInt32 = 0b1
    static let eye  : UInt32 = 0b10
    static let armDx     : UInt32 = 0b100
    static let armSx     : UInt32 = 0b1000
    static let hornDx     : UInt32 = 0b10000
    static let hornSx     : UInt32 = 0b100000
    static let mouth     : UInt32 = 0b1000000
    static let headplace : UInt32 = 0b10000000
    static let eyeplace : UInt32 = 0b11
    static let armDxPlace     : UInt32 = 0b101
    static let armSxPlace     : UInt32 = 0b1011
    static let hornDxPlace     : UInt32 = 0b10001
    static let hornSxPlace     : UInt32 = 0b100001
    static let mouthPlace     : UInt32 = 0b1000001
}
class Intro: SKScene {
    private var dragPieces : SKLabelNode?
    private var puppetBody : SKSpriteNode?
    private var head : SKSpriteNode?
    private var eyeSx : SKSpriteNode?
    private var eyeDx : SKSpriteNode?
    private var armDx : SKSpriteNode?
    private var armSx : SKSpriteNode?
    private var hornDx : SKSpriteNode?
    private var hornSx : SKSpriteNode?
    private var mouth : SKSpriteNode?
    private var headPlace : SKSpriteNode?
    private var eyeSxPlace : SKSpriteNode?
    private var eyeDxPlace : SKSpriteNode?
    private var armDxPlace : SKSpriteNode?
    private var armSxPlace : SKSpriteNode?
    private var hornDxPlace : SKSpriteNode?
    private var hornSxPlace : SKSpriteNode?
    private var mouthPlace : SKSpriteNode?
    private var currentNode : SKNode?
    private var isHeadOk = false
    private var isHornDxOk = false
    private var isHornSxOk = false
    private var isEyeDxOk = false
    private var isEyeSxOk = false
    private var isMouthOk = false
    private var isArmDxOk = false
    private var isArmSxOk = false
    private var lastPosition : CGPoint?
    private var theme : SKAudioNode?
    
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
//MARK: INITIALIZE ELEMENTS
        self.theme = self.childNode(withName: "theme") as? SKAudioNode
        self.theme?.autoplayLooped = true
        self.dragPieces = self.childNode(withName: "dragPieces") as? SKLabelNode
        self.puppetBody = self.childNode(withName: "puppetBody") as? SKSpriteNode
        self.head = self.childNode(withName: "head") as? SKSpriteNode
        self.eyeSx = self.childNode(withName: "eyeSx") as? SKSpriteNode
        self.eyeDx = self.childNode(withName: "eyeDx") as? SKSpriteNode
        self.armDx = self.childNode(withName: "armDx") as? SKSpriteNode
        self.armSx = self.childNode(withName: "armSx") as? SKSpriteNode
        self.hornDx = self.childNode(withName: "hornDx") as? SKSpriteNode
        self.hornSx = self.childNode(withName: "hornSx") as? SKSpriteNode
        self.mouth = self.childNode(withName: "mouth") as? SKSpriteNode
        self.headPlace = self.childNode(withName: "headPlace") as? SKSpriteNode
        self.eyeSxPlace  = self.childNode(withName: "eyeSxPlace") as? SKSpriteNode
        self.eyeDxPlace = self.childNode(withName: "eyeDxPlace") as? SKSpriteNode
        self.armSxPlace
        = self.childNode(withName: "armSxPlace") as? SKSpriteNode
        self.armDxPlace = self.childNode(withName: "armDxPlace") as? SKSpriteNode
        self.hornDxPlace =
        self.childNode(withName: "hornDxPlace") as? SKSpriteNode
        self.hornSxPlace = self.childNode(withName: "hornSxPlace") as? SKSpriteNode
        self.mouthPlace = self.childNode(withName: "mouthPlace") as? SKSpriteNode

//MARK: PHYSYCS BODIES
        self.head?.physicsBody = SKPhysicsBody(circleOfRadius: 119)
        self.head?.physicsBody?.affectedByGravity = false
        self.head?.physicsBody?.categoryBitMask = PhysicsCategory.head
        self.head?.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.head?.physicsBody?.contactTestBitMask = PhysicsCategory.headplace
        
        self.headPlace?.physicsBody = SKPhysicsBody(circleOfRadius: 223.5)
        self.headPlace?.physicsBody?.affectedByGravity = false
        self.headPlace?.physicsBody?.categoryBitMask = PhysicsCategory.headplace
        self.headPlace?.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.headPlace?.physicsBody?.contactTestBitMask = PhysicsCategory.head
        
        self.mouth?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 146, height: 37))
        self.mouth?.physicsBody?.affectedByGravity = false
        self.mouth?.physicsBody?.categoryBitMask = PhysicsCategory.mouth
        self.mouth?.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.mouth?.physicsBody?.contactTestBitMask = PhysicsCategory.mouthPlace
        
        self.mouthPlace?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 193, height: 50))
        self.mouthPlace?.physicsBody?.affectedByGravity = false
        self.mouthPlace?.physicsBody?.categoryBitMask = PhysicsCategory.mouthPlace
        self.mouthPlace?.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.mouthPlace?.physicsBody?.contactTestBitMask = PhysicsCategory.mouth
        
        self.eyeSx?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 61))
        self.eyeSx?.physicsBody?.affectedByGravity = false
        self.eyeSx?.physicsBody?.categoryBitMask = PhysicsCategory.eye
        self.eyeSx?.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.eyeSx?.physicsBody?.contactTestBitMask = PhysicsCategory.eyeplace
        
        self.eyeDx?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 61))
        self.eyeDx?.physicsBody?.affectedByGravity = false
        self.eyeDx?.physicsBody?.categoryBitMask = PhysicsCategory.eye
        self.eyeDx?.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.eyeDx?.physicsBody?.contactTestBitMask = PhysicsCategory.eyeplace
        
        self.eyeSxPlace?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 61))
        self.eyeSxPlace?.physicsBody?.affectedByGravity = false
        self.eyeSxPlace?.physicsBody?.categoryBitMask = PhysicsCategory.eyeplace
        self.eyeSxPlace?.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.eyeSxPlace?.physicsBody?.contactTestBitMask = PhysicsCategory.eye
        
        self.eyeDxPlace?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 61))
        self.eyeDxPlace?.physicsBody?.affectedByGravity = false
        self.eyeDxPlace?.physicsBody?.categoryBitMask = PhysicsCategory.eyeplace
        self.eyeDxPlace?.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.eyeDxPlace?.physicsBody?.contactTestBitMask = PhysicsCategory.eye
        
        self.hornDx?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 171, height: 172))
        self.hornDx?.physicsBody?.affectedByGravity = false
        self.hornDx?.physicsBody?.categoryBitMask = PhysicsCategory.hornDx
        self.hornDx?.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.hornDx?.physicsBody?.contactTestBitMask = PhysicsCategory.hornDxPlace
        
        
        self.hornSx?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 171, height: 172))
        self.hornSx?.physicsBody?.affectedByGravity = false
        self.hornSx?.physicsBody?.categoryBitMask = PhysicsCategory.hornSx
        self.hornSx?.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.hornSx?.physicsBody?.contactTestBitMask = PhysicsCategory.hornSxPlace
        
        
        self.hornDxPlace?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 265, height: 267))
        self.hornDxPlace?.physicsBody?.affectedByGravity = false
        self.hornDxPlace?.physicsBody?.categoryBitMask = PhysicsCategory.hornDx
        self.hornDxPlace?.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.hornDxPlace?.physicsBody?.contactTestBitMask = PhysicsCategory.hornDxPlace
        
        self.hornSxPlace?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 265, height: 267))
        self.hornSxPlace?.physicsBody?.affectedByGravity = false
        self.hornSxPlace?.physicsBody?.categoryBitMask = PhysicsCategory.hornSx
        self.hornSxPlace?.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.hornSxPlace?.physicsBody?.contactTestBitMask = PhysicsCategory.hornSxPlace
        
        self.armSx?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 164, height: 99))
        self.armSx?.physicsBody?.affectedByGravity = false
        self.armSx?.physicsBody?.categoryBitMask = PhysicsCategory.armSx
        self.armSx?.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.armSx?.physicsBody?.contactTestBitMask = PhysicsCategory.armSx
        
        self.armDx?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 164, height: 99))
        self.armDx?.physicsBody?.affectedByGravity = false
        self.armDx?.physicsBody?.categoryBitMask = PhysicsCategory.armDx
        self.armDx?.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.armDx?.physicsBody?.contactTestBitMask = PhysicsCategory.armDx
        
        self.armSxPlace?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 264, height: 159))
        self.armSxPlace?.physicsBody?.affectedByGravity = false
        self.armSxPlace?.physicsBody?.categoryBitMask = PhysicsCategory.armSxPlace
        self.armSxPlace?.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.armSxPlace?.physicsBody?.contactTestBitMask = PhysicsCategory.armSxPlace
        
        self.armDxPlace?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 264, height: 159))
        self.armDxPlace?.physicsBody?.affectedByGravity = false
        self.armDxPlace?.physicsBody?.categoryBitMask = PhysicsCategory.armDxPlace
        self.armDxPlace?.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.armDxPlace?.physicsBody?.contactTestBitMask = PhysicsCategory.armDxPlace

//MARK: ACTIONS
    
        let movePuppetBody = self.puppetBody?.run(SKAction.move(to: CGPoint(x: 214.478, y: -235.159), duration: 2))
        let wait = SKAction.wait(forDuration: 2)
        let fadeIn = SKAction.fadeIn(withDuration: 2)
        let fadeOut = SKAction.fadeOut(withDuration: 2)
        let fadeInOut = SKAction.sequence([fadeIn,fadeOut])
        let fadeInWait = SKAction.sequence([wait,fadeIn])
        let fadeTo1 = SKAction.sequence([wait,SKAction.fadeAlpha(to: 0.1, duration: 2)])
        let fadeTo2 = SKAction.sequence([wait,SKAction.fadeAlpha(to: 0.2, duration: 2)])
        let remove = SKAction.removeFromParent()
        
        let fadeInHead = self.head?.run(fadeInWait)
        let fadeInMouth = self.mouth?.run(fadeInWait)
        let fadeInHornSx = self.hornSx?.run(fadeInWait)
        let fadeInHornDx = self.hornDx?.run(fadeInWait)
        let fadeInEyeDx = self.eyeDx?.run(fadeInWait)
        let fadeInEyeSx = self.eyeSx?.run(fadeInWait)
        let fadeInArmDx = self.armDx?.run(fadeInWait)
        let fadeInArmSx = self.armSx?.run(fadeInWait)
        
        let fadeInHeadPlace = self.headPlace?.run(fadeTo2)
        let fadeInMouthPlace = self.mouthPlace?.run(fadeTo2)
        let fadeInHornSxPlace = self.hornSxPlace?.run(fadeTo1)
        let fadeInHornDxPlace = self.hornDxPlace?.run(fadeTo1)
        let fadeInEyeDxPlace = self.eyeDxPlace?.run(fadeTo2)
        let fadeInEyeSxPlace = self.eyeSxPlace?.run(fadeTo2)
        let fadeInArmDxPlace = self.armDxPlace?.run(fadeTo1)
        let fadeInArmSxPlace = self.armSxPlace?.run(fadeTo1)
        
        

//MARK: START SCENE
        self.run(SKAction.sequence([
            SKAction.run {
                movePuppetBody
            },SKAction.run {
                self.dragPieces?.run(SKAction.sequence([SKAction.wait(forDuration: 4),SKAction.repeatForever(fadeInOut)]))
                fadeInHead
                fadeInMouth
                fadeInArmDx
                fadeInArmSx
                fadeInEyeDx
                fadeInEyeSx
                fadeInHornDx
                fadeInHornSx
                fadeInHeadPlace
                fadeInMouthPlace
                fadeInArmDxPlace
                fadeInArmSxPlace
                fadeInHornDxPlace
                fadeInHornSxPlace
                fadeInEyeDxPlace
                fadeInEyeSxPlace
            }
        ]))
        

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dragPieces?.removeAllActions()
        self.dragPieces?.alpha = 0
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes.reversed() {
                if node.name == "head" {
                    self.lastPosition = node.position
                    self.currentNode = node
                }
                
                if node.name == "mouth" {
                    self.lastPosition = node.position
                    self.currentNode = node
                }
                
                if node.name == "eyeSx" {
                    self.lastPosition = node.position
                    self.currentNode = node
                }
                if node.name == "eyeDx" {
                    self.lastPosition = node.position
                    self.currentNode = node
                }
                if node.name == "hornDx" {
                    self.lastPosition = node.position
                    self.currentNode = node
                }
                if node.name == "hornSx" {
                    self.lastPosition = node.position
                    self.currentNode = node
                }
                if node.name == "armSx" {
                    self.lastPosition = node.position
                    self.currentNode = node
                }
                if node.name == "armDx" {
                    self.lastPosition = node.position
                    self.currentNode = node
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: self)
            node.position = touchLocation
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.currentNode?.name == "head" && !isHeadOk){
            self.currentNode?.position = self.lastPosition!
        }
        if (self.currentNode?.name == "mouth" && !isMouthOk){
            self.currentNode?.position = self.lastPosition!
        }
        
        if (self.currentNode?.name == "eyeSx" && !isEyeSxOk){
            self.currentNode?.position = self.lastPosition!
        }
        
        if (self.currentNode?.name == "eyeDx" && !isEyeDxOk){
            self.currentNode?.position = self.lastPosition!
        }
        if (self.currentNode?.name == "hornDx" && !isHornDxOk){
            self.currentNode?.position = self.lastPosition!
        }
        if (self.currentNode?.name == "hornSx" && !isHornSxOk){
            self.currentNode?.position = self.lastPosition!
        }
        if (self.currentNode?.name == "armSx" && !isArmSxOk){
            self.currentNode?.position = self.lastPosition!
        }
        if (self.currentNode?.name == "armDx" && !isArmDxOk){
            self.currentNode?.position = self.lastPosition!
        }
        self.currentNode = nil
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.currentNode?.name == "head" && !isHeadOk){
            self.currentNode?.position = self.lastPosition!
        }
        if (self.currentNode?.name == "mouth" && !isMouthOk){
            self.currentNode?.position = self.lastPosition!
        }
        if (self.currentNode?.name == "eyeSx" && !isEyeSxOk){
            self.currentNode?.position = self.lastPosition!
        }
        
        if (self.currentNode?.name == "eyeDx" && !isEyeDxOk){
            self.currentNode?.position = self.lastPosition!
        }
        if (self.currentNode?.name == "hornDx" && !isHornDxOk){
            self.currentNode?.position = self.lastPosition!
        }
        if (self.currentNode?.name == "hornSx" && !isHornSxOk){
            self.currentNode?.position = self.lastPosition!
        }
        if (self.currentNode?.name == "armSx" && !isArmSxOk){
            self.currentNode?.position = self.lastPosition!
        }
        if (self.currentNode?.name == "armDx" && !isArmDxOk){
            self.currentNode?.position = self.lastPosition!
        }
        self.currentNode = nil
    }
}
extension Intro : SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        
        let firstBody: SKPhysicsBody = contact.bodyA
        let secondBody: SKPhysicsBody = contact.bodyB
        
        if let node = firstBody.node, node.name == "head" && secondBody.node!.name == "headPlace" {
            node.removeFromParent()
            self.headPlace?.alpha = 1
            isHeadOk = true
        }
        if let node = secondBody.node, node.name == "head" && firstBody.node!.name == "headPlace"{
            node.removeFromParent()
            self.headPlace?.alpha = 1
            isHeadOk = true
        }
        if let node = firstBody.node, node.name == "mouth" && secondBody.node!.name == "mouthPlace"{
            node.removeFromParent()
            self.mouthPlace?.alpha = 1
            isMouthOk = true
        }
        if let node = secondBody.node, node.name == "mouth" && firstBody.node!.name == "mouthPlace"{
            node.removeFromParent()
            self.mouthPlace?.alpha = 1
            isMouthOk = true
        }
        
        if let node = firstBody.node, node.name == "eyeDx" && secondBody.node?.physicsBody?.categoryBitMask == PhysicsCategory.eyeplace{
            node.removeFromParent()
            if secondBody.node?.name == "eyeSxPlace"{
                self.eyeSxPlace?.alpha = 1
                self.eyeSxPlace?.physicsBody = nil
                isEyeSxOk = true
            }else{
                self.eyeDxPlace?.alpha = 1
                self.eyeDxPlace?.physicsBody = nil
                isEyeDxOk = true
            }
        }
        if let node = secondBody.node, node.name == "eyeDx" && firstBody.node?.physicsBody?.categoryBitMask == PhysicsCategory.eyeplace{
            node.removeFromParent()
            if secondBody.node?.name == "eyeSxPlace"{
                self.eyeSxPlace?.alpha = 1
                self.eyeSxPlace?.physicsBody = nil
                isEyeSxOk = true
            }else{
                self.eyeDxPlace?.alpha = 1
                self.eyeDxPlace?.physicsBody = nil
                isEyeDxOk = true
            }
        }
        if let node = firstBody.node, node.name == "eyeSx" && secondBody.node?.physicsBody?.categoryBitMask == PhysicsCategory.eyeplace{
            node.removeFromParent()
            if secondBody.node?.name == "eyeSxPlace"{
                self.eyeSxPlace?.alpha = 1
                self.eyeSxPlace?.physicsBody = nil
                isEyeSxOk = true
            }else{
                self.eyeDxPlace?.alpha = 1
                self.eyeDxPlace?.physicsBody = nil
                isEyeDxOk = true
            }
            
        }
        if let node = secondBody.node, node.name == "eyeSx" && firstBody.node?.physicsBody?.categoryBitMask == PhysicsCategory.eyeplace{
            node.removeFromParent()
            if firstBody.node?.name == "eyeSxPlace"{
                self.eyeSxPlace?.alpha = 1
                self.eyeSxPlace?.physicsBody = nil
                isEyeSxOk = true
            }else{
                self.eyeDxPlace?.alpha = 1
                self.eyeDxPlace?.physicsBody = nil
                isEyeDxOk = true
            }
        }
        if let node = firstBody.node, node.name == "hornDx" && secondBody.node!.name == "hornDxPlace" {
            node.removeFromParent()
            self.hornDxPlace?.alpha = 1
            isHornDxOk = true
        }
        if let node = secondBody.node, node.name == "hornDx" && firstBody.node!.name == "hornDxPlace"{
            node.removeFromParent()
            self.hornDxPlace?.alpha = 1
            isHornDxOk = true
        }
        if let node = firstBody.node, node.name == "hornSx" && secondBody.node!.name == "hornSxPlace" {
            node.removeFromParent()
            self.hornSxPlace?.alpha = 1
            isHornSxOk = true
        }
        if let node = secondBody.node, node.name == "hornSx" && firstBody.node!.name == "hornSxPlace"{
            node.removeFromParent()
            self.hornSxPlace?.alpha = 1
            isHornSxOk = true
        }
        if let node = firstBody.node, node.name == "armDx" && secondBody.node!.name == "armDxPlace" {
            node.removeFromParent()
            self.armDxPlace?.alpha = 1
            isArmDxOk = true
        }
        if let node = secondBody.node, node.name == "armDx" && firstBody.node!.name == "armDxPlace"{
            node.removeFromParent()
            self.armDxPlace?.alpha = 1
            isArmDxOk = true
        }
        if let node = firstBody.node, node.name == "armSx" && secondBody.node!.name == "armSxPlace" {
            node.removeFromParent()
            self.armSxPlace?.alpha = 1
            isArmSxOk = true
        }
        if let node = secondBody.node, node.name == "armSx" && firstBody.node!.name == "armSxPlace"{
            node.removeFromParent()
            self.armSxPlace?.alpha = 1
            isArmSxOk = true
        }
        if (isHeadOk&&isArmDxOk&&isArmSxOk&&isMouthOk&&isHornDxOk&&isHornSxOk&&isEyeDxOk&&isEyeSxOk){
            let body = self.childNode(withName: "puppetBody")
            let puppetComplete = self.childNode(withName: "puppetComplete")
            puppetComplete?.zPosition = 0
            self.armDxPlace?.removeFromParent()
            self.armSxPlace?.removeFromParent()
            self.hornDxPlace?.removeFromParent()
            self.hornSxPlace?.removeFromParent()
            self.mouthPlace?.removeFromParent()
            self.headPlace?.removeFromParent()
            self.eyeDxPlace?.removeFromParent()
            self.eyeSxPlace?.removeFromParent()
            self.puppetBody?.removeFromParent()
            puppetComplete?.run(SKAction.sequence([SKAction.move(to: CGPoint(x: 0, y: 0), duration: 3),SKAction.run {
                self.theme?.run(SKAction.changeVolume(to: 0, duration: 5))
            },SKAction.wait(forDuration: 5),SKAction.run {
                let scene = Scene1(fileNamed: "Scene1")
                scene?.scaleMode = .aspectFit
                self.view?.presentScene(scene)
            }]))
        }
    }
   
}
