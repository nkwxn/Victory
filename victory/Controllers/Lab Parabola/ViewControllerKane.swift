////
////  ViewController.swift
////  SpriteKit Trial
////
////  Created by Nicholas on 06/06/21.
////
//
//import UIKit
//import SpriteKit
//
//class ViewController: UIViewController {
//    @IBOutlet weak var settingsTableView: UITableView!
//    @IBOutlet weak var skView: SKView!
//    @IBOutlet weak var timeMasterOutlet: UISlider!
//    @IBOutlet weak var kecOutlet: UISlider!
//
//    var kecAwalyey: Float = 15
//    var kecMax : Float = 15
//    var sudutFirst: Double = 45
//    var engine = VictoryEngine()
//    var gravitasi : Float = 9.8
//    var totalWaktuEngine : Float = 0
//    var totalWaktuReal : Float = 0
//    var waktuEngine : Float = 0
//    var waktuRealtime : Float = 0
//    var posisiXRealTime: Float = 0
//    var posisiYRealTime: Float = 0
//    var posisiXMaxReal : Float = 0
//
//    var perpindahanXDalamPoin : Float = 0
//    var timeMasterClicked = false
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // TableView delegate setup
//        settingsTableView.delegate = self
//        settingsTableView.dataSource = self
//        timeMasterOutlet.value = 1
//        kecOutlet.value = 1
//
//        // SpriteScene Kit Setup
//        let scene = SpriteScene(size: view.bounds.size)
//        scene.delegate = self
//        skView.showsFPS = true
//        skView.ignoresSiblingOrder = true
//        scene.scaleMode = .resizeFill
//        skView.presentScene(scene)
//
//
//        totalWaktuEngine = engine.waktuUntukJarakTerjauhEngine(kecepatanAwal: kecAwalyey, sudutTembak: sudutFirst, gravitasi: gravitasi )
//
//        totalWaktuReal =  engine.waktuUntukJarakTerjauhReal(kecepatanAwal: kecAwalyey, sudutTembak: sudutFirst, gravitasi: gravitasi)
//
//    }
//
//
//    @IBAction func sliderUhuy(_ sender: UISlider) {
//        kecAwalyey = Float(sender.value * kecMax)
//
//        totalWaktuEngine = engine.waktuUntukJarakTerjauhEngine(kecepatanAwal: kecAwalyey, sudutTembak: sudutFirst, gravitasi: gravitasi)
//
//        totalWaktuReal = engine.waktuUntukJarakTerjauhReal(kecepatanAwal: kecAwalyey, sudutTembak: sudutFirst, gravitasi: gravitasi)
//        settingsTableView.reloadData()
//
//        if let gameScene = skView.scene as? SpriteScene {
//            gameScene.totalWaktuEngine = totalWaktuEngine
//            gameScene.kecAwalScene = kecAwalyey
//            gameScene.totalWaktuReal = totalWaktuReal
//        }
//    }
//
//    @IBAction func shootButtonClicked(_ sender: UIBarButtonItem) {
//        timeMasterClicked = false
//        if let gameScene = skView.scene as? SpriteScene {
//            gameScene.shootStraight(kecAwal: kecAwalyey)
//        }
//    }
//
//    @IBAction func timeMaster(_ sender: UISlider) {
//        timeMasterClicked = true
//        waktuEngine = totalWaktuEngine * sender.value
//        waktuRealtime = totalWaktuReal * sender.value
//        if let gameScene = skView.scene as? SpriteScene {
//            gameScene.lineActive = false
//
//            let posisiX = engine.xProyektilTerhadapWaktuEngine(kecepatanAwal: kecAwalyey, sudutTembak: sudutFirst, waktu: waktuEngine)
//
//            posisiXRealTime = Float(engine.xProyektilTerhadapWaktuReal(kecepatanAwal: kecAwalyey, sudutTembak: sudutFirst, waktu: waktuRealtime))
//
//            let posisiY = engine.yProyektilTerhadapWaktuEngine(kecepatanAwal: kecAwalyey, sudutTembak: sudutFirst, waktu: waktuEngine, gravitasi: gravitasi)
//
//            posisiYRealTime = Float(engine.yProyektilTerhadapWaktuReal(kecepatanAwal: kecAwalyey, sudutTembak: sudutFirst, waktu: waktuRealtime, gravitasi: gravitasi))
//
//            gameScene.currentProjectile?.physicsBody?.velocity = .zero
//            gameScene.currentProjectile?.physicsBody?.affectedByGravity = false
//            gameScene.currentProjectile?.position = CGPoint(x: posisiX + gameScene.player.position.x, y: posisiY + gameScene.player.position.y)
//        }
//        settingsTableView.reloadData()
//    }
//
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            return .landscape
//        } else {
//            return .all
//        }
//    }
//}
//
//extension ViewController: SKSceneDelegate {
//    func update(_ currentTime: TimeInterval, for scene: SKScene) {
//        if let gameScene = scene as? SpriteScene {
//            let cells = settingsTableView.visibleCells
//            let monsterDestroyedCell = cells[1]
//            monsterDestroyedCell.detailTextLabel?.text = "\(gameScene.getUdaraDitembakCie())"
//            perpindahanXDalamPoin = gameScene.getPerpindahanXDalamPoin()
//            posisiXMaxReal = gameScene.getJarakXMaxReal()
//
//            if timeMasterClicked == false {
//                if gameScene.jarakXRealtime < gameScene.jarakXMaxReal {
//                    posisiXRealTime = gameScene.getJarakXRealtime()
//                    posisiYRealTime = gameScene.getJarakYRealtime()
//                    waktuRealtime = gameScene.getWaktuRealtime()
//
//                } else {
//                    posisiXRealTime = gameScene.jarakXMaxReal
//                    posisiYRealTime = 0
//                    waktuRealtime = gameScene.totalWaktuReal
//                }
//            }
//
//            settingsTableView.reloadData()
//        }
//    }
//}
//
//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell
//        switch indexPath.row {
//        case 0:
//            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//            cell.textLabel?.text = "Poin"
//            cell.detailTextLabel?.text = "\(round(perpindahanXDalamPoin*100)/100)"
//            return cell
//        case 1:
//            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//            cell.textLabel?.text = "KecAwal"
//            cell.detailTextLabel?.text = "\(kecAwalyey)"
//            return cell
//        case 2:
//            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//            cell.textLabel?.text = "Waktu"
//            cell.detailTextLabel?.text = String(round(waktuRealtime*100)/100)
//            return cell
//        case 3:
//            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//            cell.textLabel?.text = "PosisiX"
//            cell.detailTextLabel?.text = String(round(posisiXRealTime*100)/100)
//            return cell
//        case 4:
//            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//            cell.textLabel?.text = "PosisiY"
//            cell.detailTextLabel?.text = String(round(posisiYRealTime * 100)/100)
//            return cell
//        case 5:
//            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//            cell.textLabel?.text = "PosisiY"
//            cell.detailTextLabel?.text = String(round(posisiYRealTime * 100)/100)
//            return cell
//        case 6:
//            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//            cell.textLabel?.text = "PosisiY"
//            cell.detailTextLabel?.text = String(round(posisiYRealTime * 100)/100)
//            return cell
//        default:
//            cell = UITableViewCell()
//            return cell
//        }
//    }
//
//    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}
