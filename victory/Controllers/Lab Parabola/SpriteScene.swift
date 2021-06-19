//
//  SpriteKitSceneCode.swift
//  SpriteKit Trial
//
//  Created by Nicholas on 06/06/21.
//

import UIKit
import SpriteKit

class SpriteScene: SKScene {
    let player = SKSpriteNode(imageNamed: "badanMeriam") // Initializing the player node
    let bg = SKSpriteNode(imageNamed: "background")
    let roda = SKSpriteNode(imageNamed: "roda")
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
    var gravitasiVektor : Float = -9.8
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
    var kecTotal : Float = 0
    var kecepatanXReal : Float = 0
    var kecepatanYreal : Float = 0
    var ketinggianReal : Float = 0
    var ketinggianEngine : Float = 0
    
    var initialX : CGFloat = 0
    var initialY : CGFloat = 0
    
    
    override func didEvaluateActions() {
        super.didEvaluateActions()
        physicsWorld.gravity = CGVector(dx: 0, dy: CGFloat(gravitasiVektor))
    }
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        player.position = CGPoint(x: initialX, y: initialY)
    }
    
    override func didApplyConstraints() {
        super.didApplyConstraints()
        
//        vectorY.removeFromParent()
//        vectorX.removeFromParent()
//        vectorX = SKShapeNode(rectOf: CGSize(width: currentProjectile?.physicsBody?.velocity.dx ?? 0, height: 20))
//        vectorX.fillColor = SKColor.red
//
//        vectorX.position.x = CGFloat(0.5 * (currentProjectile?.physicsBody?.velocity.dx ?? 0))
//        vectorX.position.y = CGFloat(0)
//
//        vectorY = SKShapeNode(rectOf: CGSize(width: 20, height: currentProjectile?.physicsBody?.velocity.dy ?? 0))
//        vectorY.position.x = CGFloat(0)
//        vectorY.position.y = CGFloat(0.5 * (currentProjectile?.physicsBody?.velocity.dy ?? 0))
//        vectorY.fillColor = SKColor.blue
//        currentProjectile?.addChild(vectorX)
//        currentProjectile?.addChild(vectorY)
        player.zRotation = CGFloat(sudutTembakScene)/55 + 30.15
        
        
        if lineActive == true {
            
            
            //        guard let positionBuled = currentProjectile?.position else {return}
            for projectileSekarang in projectileArray {
                if projectileSekarang.physicsBody?.velocity != nil && projectileSekarang.physicsBody?.velocity != .zero {
                    let buled = SKShapeNode(circleOfRadius: 5)
//                    buled.zPosition = -0.1
                    buled.fillColor = SKColor.red
                    buled.position = projectileSekarang.position
                    guard indexBentol % 10 == 0 else {
                        indexBentol += 1
                        return
                    }
                    if children.count > janganDihapusArray.count  {
                        if buled.position.y != CGFloat(0) {
                            addChild(buled)
                            nodeArrayDeletable.append(buled)
                        }
                    }
                    
                }
            }
            indexBentol += 1
        }
        
        guard let posisiXProjectile = currentProjectile?.position.x else {return}
        
        let perpindahanX = Float(posisiXProjectile - initialX)
        perpindahanXDalamPoin = perpindahanX / poinKeMeterDibagi
        jarakXMaxEngine = Float(engineSK.xProyektilTerhadapWaktuEngine(kecepatanAwal: kecAwalScene, sudutTembak: sudutTembakScene, waktu: totalWaktuEngine))
        jarakXMaxReal = Float(engineSK.xProyektilTerhadapWaktuReal(kecepatanAwal: kecAwalScene, sudutTembak: sudutTembakScene,waktu: totalWaktuReal))
        
        
//        //otwapos
//        jarakYMaxReal = Float(engineSK.yProyektilTerhadapWaktuReal(kecepatanAwal: kecAwalScene, sudutTembak: sudutTembakScene, waktu: 0.5 * totalWaktuReal, gravitasi: gravitasiVektor))
        
        var rasioXEngine = perpindahanX/jarakXMaxEngine
        
        if jarakXRealtime <= jarakXMaxReal {
            jarakXRealtime = rasioXEngine * jarakXMaxReal
            waktuRealTime = rasioXEngine * totalWaktuReal
            
            kecepatanXReal = Float(engineSK.kecepatanXAwalReal(sudutTembak: sudutTembakScene, kecepatanAwal: kecAwalScene))
            kecepatanYreal = Float(engineSK.kecepatanY(sudutTembak: sudutTembakScene, kecepatanAwal: kecAwalScene, waktu: waktuRealTime, gravitasi: gravitasiVektor))
            
            let kecepatanXKuadrat = pow(kecepatanXReal, 2)
            let kecepatanYKuadrat = pow(kecepatanYreal,2)
            kecTotal = pow(kecepatanXKuadrat + kecepatanYKuadrat, 0.5)
            
            if rasioXEngine > 0.5 {
                let bedanya = rasioXEngine - 0.5
                rasioXEngine = 0.5 - bedanya
            }
            jarakYRealtime = Float(engineSK.yProyektilTerhadapWaktuReal(kecepatanAwal: kecAwalScene, sudutTembak: sudutTembakScene, waktu: waktuRealTime, gravitasi: gravitasiVektor))
        }

//        player.size = CGSize(width: currentProjectile?.physicsBody?.velocity.dx ?? 100 , height: currentProjectile?.physicsBody?.velocity.dy ?? 100)
    }
    
    
    
    override func didFinishUpdate() {
        super.didFinishUpdate()
       
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0, dy: CGFloat(gravitasiVektor))
        initialX = size.width * 0.1
        initialY = size.height * 0.2
        player.position = CGPoint(x: initialX, y: initialY)

        
        bg.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        bg.zPosition = -1
        addChild(bg)
        print("background cukces")

        
        player.anchorPoint = CGPoint(x: 0.45, y: 0.3)
        player.zPosition = 0.5
        roda.zPosition = 1
        player.addChild(roda)
        
//        player.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        addChild(player)
        janganDihapusArray.append(player)
        
        backgroundColor = SKColor.white // Set the background color
        
        physicsWorld.contactDelegate = self
        physicsWorld.speed = 0.3
        
        
        
        
        projectileArray = [projectile,projectile1,projectile2,projectile3,projectile4, projectile5,projectile6, projectile7, projectile8,projectile9, projectile10]
        
//        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: UIEdgeInsets(top: 210, left: 0, bottom: 0, right: 0)))
        
        totalWaktuEngine = engineSK.waktuUntukJarakTerjauhEngine(kecepatanAwal: kecAwalScene, sudutTembak: sudutTembakScene, gravitasi: gravitasiVektor, ketinggian: ketinggianEngine )
        totalWaktuReal = engineSK.waktuUntukJarakTerjauhReal(kecepatanAwal: kecAwalScene, sudutTembak: sudutTembakScene, gravitasi: gravitasiVektor, ketinggian: ketinggianReal)
        
        
        print("ini tinggi \(String(describing: scene?.size.height)), ini panjang \(String(describing: scene?.size.width))")
        
        let lantai = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 3000, height: 10))
        lantai.position = CGPoint(x: initialX, y: initialY - 15)
        lantai.zPosition = 0.3
        lantai.physicsBody = SKPhysicsBody(rectangleOf: lantai.size)
        lantai.physicsBody!.isDynamic = false
        lantai.physicsBody?.allowsRotation = false
        lantai.physicsBody?.linearDamping = 0
        lantai.physicsBody?.angularDamping = 0
        lantai.physicsBody?.friction = 1
        lantai.physicsBody?.restitution = 0
        lantai.physicsBody?.categoryBitMask = PhysicsCategory.tembok
        lantai.physicsBody?.contactTestBitMask = PhysicsCategory.projectile
//        lantai.physicsBody?.collisionBitMask = PhysicsCategory.none
        lantai.physicsBody?.usesPreciseCollisionDetection = true
        self.addChild(lantai)
//
        
        

  
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for node in nodeArrayDeletable {
            node.removeFromParent()
        }
        for projectileSekarang in projectileArray {
            projectileSekarang.position = CGPoint(x: initialX, y: initialY)
            projectileSekarang.physicsBody?.velocity = .zero
            
        }
        index = 0
        
        print("aw kepencet -----------------------------------------")
    }
    
    func resetLab() {
        for node in nodeArrayDeletable {
            node.removeFromParent()
        }
        for projectileSekarang in projectileArray {
            projectileSekarang.position = CGPoint(x: initialX, y: initialY)
            projectileSekarang.physicsBody?.velocity = .zero
            
        }
        index = 0
        
        print("aw kepencet -----------------------------------------")
    }
    
    func shootStraight(kecAwal: Float) {
        
        lineActive = true
        jarakXMaxReal = 0
        jarakXRealtime = 0
        
        guard index < projectileArray.count else {return}
 
        currentProjectile = projectileArray[index]
        currentProjectile?.position = CGPoint(x: initialX, y: initialY)
        currentProjectile?.zPosition = 0.3
        currentProjectile?.physicsBody = SKPhysicsBody(circleOfRadius: currentProjectile!.size.width/2)
        currentProjectile?.physicsBody?.isDynamic = true
        currentProjectile?.physicsBody?.allowsRotation = false
        currentProjectile?.physicsBody?.linearDamping = 0
        currentProjectile?.physicsBody?.angularDamping = 0
        currentProjectile?.physicsBody?.friction = 1
        currentProjectile?.physicsBody?.restitution = 0
        currentProjectile?.physicsBody?.categoryBitMask = PhysicsCategory.projectile
        currentProjectile?.physicsBody?.contactTestBitMask = PhysicsCategory.tembok
//                currentProjectile?.physicsBody?.collisionBitMask = PhysicsCategory.none
                currentProjectile?.physicsBody?.usesPreciseCollisionDetection = true
        //
        
        currentProjectile?.physicsBody?.velocity = CGVector(dx: engineSK.kecepatanXAwalEngine(sudutTembak: sudutTembakScene, kecepatanAwal: kecAwal), dy: engineSK.kecepatanYAwalEngine(sudutTembak: sudutTembakScene, kecepatanAwal: kecAwal))
        
        addChild(currentProjectile ?? projectile)
        
        nodeArrayDeletable.append(currentProjectile ?? projectile)
        index += 1
        
    }
    
    func projectileDidCollideWithTembox(projectile: SKSpriteNode, tembox: SKSpriteNode) {
        print("Hit")
        projectile.physicsBody?.velocity = .zero
        
//        udaraDitembakCie += 1
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
        if ((firstBody.categoryBitMask & PhysicsCategory.tembok != 0) &&
                (secondBody.categoryBitMask & PhysicsCategory.projectile != 0)) {
            print("yahooo1")
            if let tembox = firstBody.node as? SKSpriteNode,
               let projectile = secondBody.node as? SKSpriteNode {
                print("yahooo2")
                projectileDidCollideWithTembox(projectile: projectile, tembox: tembox)
                
                //                projectileDidCollideWithUdara(projectile: projectile, monster: monster)
            }
        }
    }
}

// MARK: - GET GET GETAE
extension SpriteScene {
    
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
    
    func getKecepatanTotal () -> Float {
        return kecTotal
    }
    
    func getKecepatanXReal () -> Float {
        return kecepatanXReal
    }
    
    func getKecepatanYReal () -> Float {
        return kecepatanYreal
    }
}

// MARK: - Tumbukan kawan~
struct PhysicsCategory {
    static let none      : UInt32 = 0
    static let all       : UInt32 = UInt32.max
    static let tembok   : UInt32 = 0b1      // 1
    static let projectile: UInt32 = 0b10 //2
    static let bentol: UInt32 = 0b11 //3
}

