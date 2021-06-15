//
//  SpriteKitSceneCode.swift
//  SpriteKit Trial
//
//  Created by Nicholas on 06/06/21.
//

import UIKit
import SpriteKit

class SpriteScene: SKScene {
    let player = SKSpriteNode(imageNamed: "player") // Initializing the player node
    let projectile = SKSpriteNode(imageNamed: "projectile")
    let projectile1 = SKSpriteNode(imageNamed: "projectile")
    let projectile2 = SKSpriteNode(imageNamed: "projectile")
    let projectile3 = SKSpriteNode(imageNamed: "projectile")
    let projectile4 = SKSpriteNode(imageNamed: "projectile")
    let projectile5 = SKSpriteNode(imageNamed: "projectile")
    let projectile6 = SKSpriteNode(imageNamed: "projectile")
    let projectile7 = SKSpriteNode(imageNamed: "projectile")
    let projectile8 = SKSpriteNode(imageNamed: "projectile")
    let projectile9 = SKSpriteNode(imageNamed: "projectile")
    let projectile10 = SKSpriteNode(imageNamed: "projectile")
    var projectileArray : [SKSpriteNode] = []
    var currentProjectile : SKSpriteNode?
    var previousProjectile : SKSpriteNode?
    
    var vectorX = SKShapeNode(rectOf: CGSize(width: 0, height: 0))
    var vectorY = SKShapeNode(rectOf: CGSize(width: 0, height: 0))
    
    
    var index : Int = 0
    
    
    var monstersDestroyed = 0
    var engineSK = VictoryEngine()
    var waktuArray : [Int] = []
    var xArray : [CGFloat] = []
    var yArray : [CGFloat] = []
    var kecAwalScene : Float = 15
    var gravitasi : Float = 10
    var sudutTembakScene : Double = 30
    var udaraDitembakCie = 0
    var indexBentol = 0
    var lineActive : Bool = true
    var initialTime : TimeInterval = 0
    var nodeArrayDeletable : [SKNode] = []
    var janganDihapusArray : [SKNode] = []
    
    //Variabel konversi
    var poinKeMeterDibagi : Float = 15
    var perpindahanXDalamPoin : Float = 0
    
    //variabel passing lambung
    var totalWaktuEngine : Float = 0
    var totalWaktuReal : Float = 0
    var waktuRealTime : Float = 0
    var jarakXMaxEngine : Float = 0
    var jarakXMaxReal : Float = 0
    var jarakYMaxReal : Float = 0
    var jarakXRealtime : Float = 0
    var jarakYRealtime : Float = 0
    
    func getUdaraDitembakCie() -> Int {
        return udaraDitembakCie
    }
    
    func getPerpindahanXDalamPoin () -> Float {
        return perpindahanXDalamPoin
    }
    
    func getJarakXRealtime () -> Float {
        return jarakXRealtime
    }
    
    func getJarakYRealtime () -> Float {
        return jarakYRealtime
    }
    func getJarakXMaxReal () -> Float {
        return jarakXMaxReal
    }
    
    func getWaktuRealtime () -> Float {
        return waktuRealTime
    }
    
    //    override func update(_ currentTime: TimeInterval) {
    //            if currentTime - initialTime >= 1 {
    //                print("jarak nya \(projectile.position.x - player.position.x), pada waktu \(Date())")
    //
    //            }
    //    }
    
    //    override func didFinishUpdate() {
    //        print("jarak nya \(projectile.position.x - player.position.x), pada waktu \(Date())")
    //    }
    
    
    override func didSimulatePhysics() {
        
        super.didSimulatePhysics()
        /*
        if lineActive == true {
            
            //        guard let positionBuled = currentProjectile?.position else {return}
            for projectile in projectileArray {
                let buled = SKShapeNode(circleOfRadius: 5)
                buled.fillColor = SKColor.blue
                buled.position = projectile.position
                guard indexBentol % 20 == 0 else {
                    indexBentol += 1
                    return
                }
                
                if children.count > janganDihapusArray.count {
                    addChild(buled)
                    nodeArrayDeletable.append(buled)
                }
            }
            indexBentol += 1
        }
        */
        guard let posisiXProjectile = currentProjectile?.position.x else {return}
        
        let perpindahanX = Float(posisiXProjectile - player.position.x)
        perpindahanXDalamPoin = perpindahanX / poinKeMeterDibagi
        jarakXMaxEngine = Float(engineSK.xProyektilTerhadapWaktuEngine(kecepatanAwal: kecAwalScene, sudutTembak: sudutTembakScene, waktu: totalWaktuEngine))
        
        // Jarak Maksimum
        jarakXMaxReal = Float(engineSK.xProyektilTerhadapWaktuReal(kecepatanAwal: kecAwalScene, sudutTembak: sudutTembakScene,waktu: totalWaktuReal))
        
        // Ketinggian Maksimum
        jarakYMaxReal = Float(engineSK.yProyektilTerhadapWaktuReal(kecepatanAwal: kecAwalScene, sudutTembak: sudutTembakScene, waktu: 0.5 * totalWaktuReal, gravitasi: gravitasi))
        
        var rasioXEngine = perpindahanX/jarakXMaxEngine
        
        if jarakXRealtime <= jarakXMaxReal {
            jarakXRealtime = rasioXEngine * jarakXMaxReal
            waktuRealTime = rasioXEngine * totalWaktuReal
            
            if rasioXEngine > 0.5 {
                let bedanya = rasioXEngine - 0.5
                rasioXEngine = 0.5 - bedanya
            }
            jarakYRealtime = 2 * rasioXEngine * jarakYMaxReal
        }
        
        
      
        
        //        if gameScene.jarakXRealtime < gameScene.jarakXMaxReal {
        //            posisiXRealTime = gameScene.getJarakXRealtime()
        //            posisiYRealTime = gameScene.getJarakYRealtime()
        //        }
        //
        //        if gameScene.jarakXRealtime > gameScene.jarakXMaxReal + gameScene.jarakXMaxReal * 0.1 {
        //            posisiXRealTime = gameScene.jarakXMaxReal
        //            posisiYRealTime = 0
        //        }
    }
    
    override func didApplyConstraints() {
        super.didApplyConstraints()
        
        
        
    }
    
    override func didFinishUpdate() {
        super.didFinishUpdate()
        vectorY.removeFromParent()
        vectorX.removeFromParent()
        vectorX = SKShapeNode(rectOf: CGSize(width: currentProjectile?.physicsBody?.velocity.dx ?? 0, height: 20))
        vectorX.fillColor = SKColor.red
        
        vectorX.position.x = CGFloat(0.5 * (currentProjectile?.physicsBody?.velocity.dx ?? 0))
        vectorX.position.y = CGFloat(0)
        
        vectorY = SKShapeNode(rectOf: CGSize(width: 20, height: currentProjectile?.physicsBody?.velocity.dy ?? 0))
        vectorY.position.x = CGFloat(0)
        vectorY.position.y = CGFloat(0.5 * (currentProjectile?.physicsBody?.velocity.dy ?? 0))
        vectorY.fillColor = SKColor.blue
        currentProjectile?.addChild(vectorX)
        currentProjectile?.addChild(vectorY)
    }
    
    override func didMove(to view: SKView) {
        //        print(scene?.size.width)
        //        print(scene?.size.height)
        player.position = CGPoint(x: size.width * 0.01, y: size.height * 0.5)
        addChild(player)
        janganDihapusArray.append(player)
        
        backgroundColor = SKColor.white // Set the background color
        
        physicsWorld.contactDelegate = self
        physicsWorld.speed = 0.3
        
        
        
        
        projectileArray = [projectile,projectile1,projectile2,projectile3,projectile4, projectile5,projectile6, projectile7, projectile8,projectile9, projectile10]
        
        for projectile in projectileArray {
            projectile.position = player.position
        }
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: UIEdgeInsets(top: 210, left: 0, bottom: 0, right: 0)))
        
        totalWaktuEngine = engineSK.waktuUntukJarakTerjauhEngine(kecepatanAwal: kecAwalScene, sudutTembak: sudutTembakScene, gravitasi: gravitasi )
        
        totalWaktuReal = engineSK.waktuUntukJarakTerjauhReal(kecepatanAwal: kecAwalScene, sudutTembak: sudutTembakScene, gravitasi: gravitasi)
        print("\(totalWaktuReal) s")
        
        //        print("ini tinggi \(scene?.size.height), ini panjang \(scene?.size.width)")
        //        let leftWall = SKSpriteNode(color: UIColor.brown, size: CGSize(width: 100, height: frame.height))
        //        leftWall.position = CGPoint(x: 200, y: 100)
        //        leftWall.physicsBody = SKPhysicsBody(rectangleOf: leftWall.size)
        //        leftWall.physicsBody!.isDynamic = false
        //        self.addChild(leftWall)
        
        /*
        
        var tinggiM = 0
        var lebarM = 0
        for i in stride(from: 5, to: (scene?.size.width)!, by: CGFloat(poinKeMeterDibagi)) {
            //            for j in stride(from: player.position.y, to: view.bounds.height, by: 10){
            let udaraAnying = SKShapeNode(circleOfRadius: 5)
            udaraAnying.fillColor = SKColor.red
            udaraAnying.position = CGPoint(x: i, y: 200)
            //                udaraAnying.physicsBody = SKPhysicsBody(circleOfRadius: 5)
            //                udaraAnying.physicsBody?.categoryBitMask = PhysicsCategory.udaraAnying // 3
            //                udaraAnying.physicsBody?.contactTestBitMask = PhysicsCategory.projectile // 4
            //                udaraAnying.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
            //                udaraAnying.physicsBody?.usesPreciseCollisionDetection = true
            //                udaraAnying.physicsBody?.mass = 0.0000000001
            //                udaraAnying.physicsBody?.affectedByGravity = false
            //                udaraAnying.physicsBody?.restitution = 0
            //                udaraAnying.physicsBody?.friction = 0
            self.addChild((udaraAnying))
            lebarM += 1
            //            }
        }
        
        for i in stride(from: 5, to: (scene?.size.height)!, by: CGFloat(poinKeMeterDibagi)) {
            //            for j in stride(from: player.position.y, to: view.bounds.height, by: 10){
            let udaraAnying = SKShapeNode(circleOfRadius: 5)
            udaraAnying.fillColor = SKColor.red
            udaraAnying.position = CGPoint(x: 5, y: i)
            //                udaraAnying.physicsBody = SKPhysicsBody(circleOfRadius: 5)
            //                udaraAnying.physicsBody?.categoryBitMask = PhysicsCategory.udaraAnying // 3
            //                udaraAnying.physicsBody?.contactTestBitMask = PhysicsCategory.projectile // 4
            //                udaraAnying.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
            //                udaraAnying.physicsBody?.usesPreciseCollisionDetection = true
            //                udaraAnying.physicsBody?.mass = 0.0000000001
            //                udaraAnying.physicsBody?.affectedByGravity = false
            //                udaraAnying.physicsBody?.restitution = 0
            //                udaraAnying.physicsBody?.friction = 0
            self.addChild((udaraAnying))
            tinggiM += 1
            //            }
        }
        
        
        
        print("lebarnya \(lebarM), tingginya \(tinggiM)") */
        // Run the sequence of action of spawning monster
        //        run(SKAction.repeatForever(
        //            SKAction.sequence([
        //                SKAction.run(addMonster),
        //                SKAction.wait(forDuration: 1.0)
        //            ])
        //        ))
        //
        //        // Adding the background music
        //        let backgroundMusic = SKAudioNode(fileNamed: "background-music-aac.caf")
        //        backgroundMusic.autoplayLooped = true
        //        addChild(backgroundMusic)
        
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 4294967296)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max-min) + min
    }
    
    func resetLab() {
        for node in nodeArrayDeletable {
            node.removeFromParent()
        }
        for projectile in projectileArray {
            projectile.position = player.position
        }
        index = 0
    }
    
    func shootStraight(kecAwal: Float) {
        
        lineActive = true
        jarakXMaxReal = 0
        jarakXRealtime = 0
        guard index < projectileArray.count else {return}
        //        run(SKAction.playSoundFileNamed("pew-pew-lei.caf", waitForCompletion: false))
        //
        //        vectorY.removeFromParent()
        //        vectorX.removeFromParent()
        
        
        currentProjectile = projectileArray[index]
        
        
        
        projectileArray[index].position = player.position
        
        currentProjectile?.physicsBody = SKPhysicsBody(circleOfRadius: currentProjectile!.size.width/3)
        currentProjectile?.physicsBody?.isDynamic = true
        currentProjectile?.physicsBody?.allowsRotation = false
        currentProjectile?.physicsBody?.linearDamping = 0
        currentProjectile?.physicsBody?.angularDamping = 0
        currentProjectile?.physicsBody?.friction = 1
        currentProjectile?.physicsBody?.restitution = 0
        currentProjectile?.physicsBody?.categoryBitMask = PhysicsCategory.projectile
        currentProjectile?.physicsBody?.contactTestBitMask = PhysicsCategory.udaraAnying
        //        currentProjectile?.physicsBody?.collisionBitMask = PhysicsCategory.none
        //        currentProjectile?.physicsBody?.usesPreciseCollisionDetection = true
        //
        currentProjectile?.physicsBody?.velocity = CGVector(dx: engineSK.kecepatanXAwalEngine(sudutTembak: 45, kecepatanAwal: kecAwal), dy: engineSK.kecepatanYAwalEngine(sudutTembak: 45, kecepatanAwal: kecAwal))
        
        print(engineSK.kecepatanXAwalEngine(sudutTembak: 45, kecepatanAwal: kecAwal))
        
        addChild(currentProjectile ?? projectile)
        
        nodeArrayDeletable.append(currentProjectile ?? projectile)
        index += 1
        
    }
    
    func projectileDidCollideWithUdaraAnying(projectile: SKSpriteNode, udaraAnying: SKShapeNode) {
        print("Hit")
        udaraAnying.removeFromParent()
        
        udaraDitembakCie += 1
        //        if monstersDestroyed > 30 {
        //            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        //            let gameOverScene = GameOverScene(size: self.size, won: true)
        //            view?.presentScene(gameOverScene, transition: reveal)
        //        }
    }
}

extension SpriteScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 2
        if ((firstBody.categoryBitMask & PhysicsCategory.udaraAnying != 0) &&
                (secondBody.categoryBitMask & PhysicsCategory.projectile != 0)) {
            if let udaraAnying = firstBody.node as? SKShapeNode,
               let projectile = secondBody.node as? SKSpriteNode {
                projectileDidCollideWithUdaraAnying(projectile: projectile, udaraAnying: udaraAnying)
                //                projectileDidCollideWithUdara(projectile: projectile, monster: monster)
            }
        }
    }
}


struct PhysicsCategory {
    static let none      : UInt32 = 0
    static let all       : UInt32 = UInt32.max
    static let udaraAnying   : UInt32 = 0b1      // 1
    static let projectile: UInt32 = 0b10 //2
    static let bentol: UInt32 = 0b11 //3
}

//func +(left: CGPoint, right: CGPoint) -> CGPoint {
//    return CGPoint(x: left.x + right.x, y: left.y + right.y)
//}
//
//func -(left: CGPoint, right: CGPoint) -> CGPoint {
//    return CGPoint(x: left.x - right.x, y: left.y - right.y)
//}
//
//func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
//    return CGPoint(x: point.x * scalar, y: point.y * scalar)
//}
//
//func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
//    return CGPoint(x: point.x / scalar, y: point.y / scalar)
//}
//
//#if !(arch(x86_64) || arch(arm64))
//func sqrt(a: CGFloat) -> CGFloat {
//    return CGFloat(sqrtf(Float(a)))
//}
//#endif
//
//extension CGPoint {
//    func length() -> CGFloat {
//        return sqrt(x*x + y*y)
//    }
//
//    func normalized() -> CGPoint {
//        return self / length()
//    }
//}
