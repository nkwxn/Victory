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
//    @IBOutlet weak var ketinggianOutlet: UISlider!
//    @IBOutlet weak var sudutOutlet: UISlider!
//
//
//    var kecAwalyey: Float = 15
//    var kecMax : Float = 15
//    var sudutFirst: Double = 45
//    var sudutFirstDummy: Double = 45
//    var engine = VictoryEngine()
//    var gravitasiVektor : Float = -9.8
//    var totalWaktuEngine : Float = 0
//    var totalWaktuReal : Float = 0
//    var waktuEngine : Float = 0
//    var waktuRealtime : Float = 0
//    var posisiXRealTime: Float = 0
//    var posisiYRealTime: Float = 0
//    var posisiXMaxReal : Float = 0
//
//    var kecTotal : Float = 0
//    var kecepatanXReal : Float = 0
//    var kecepatanYReal : Float = 0
//    var ketinggianReal : Float = 0
//    var ketinggianEngine : Float = 0
//
//
//
//    var perpindahanXDalamPoin : Float = 0
//    var timeMasterClicked = false
//
//    var initialX : Float = 0
//    var initialY : Float = 0
//
//
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
//        totalWaktuEngine = engine.waktuUntukJarakTerjauhEngine(kecepatanAwal: kecAwalyey, sudutTembak: sudutFirst, gravitasi: gravitasiVektor, ketinggian: ketinggianEngine )
//
//        totalWaktuReal =  engine.waktuUntukJarakTerjauhReal(kecepatanAwal: kecAwalyey, sudutTembak: sudutFirst, gravitasi: gravitasiVektor, ketinggian: ketinggianReal)
//
//        sudutOutlet.maximumValue = 90
//        sudutOutlet.minimumValue = 0
//        sudutOutlet.value = sudutOutlet.maximumValue/2
//
//        ketinggianOutlet.minimumValue = 0
//        ketinggianOutlet.maximumValue = 5
//        ketinggianOutlet.value = ketinggianOutlet.maximumValue/2
//
//    }
//
//
//
//
//    @IBAction func ketinggianUhuy(_ sender: UISlider) {
//        ketinggianReal = sender.value
//        ketinggianEngine = sender.value * 50
//
//        totalWaktuEngine = engine.waktuUntukJarakTerjauhEngine(kecepatanAwal: kecAwalyey, sudutTembak: sudutFirst, gravitasi: gravitasiVektor, ketinggian: ketinggianEngine)
//        totalWaktuReal = engine.waktuUntukJarakTerjauhReal(kecepatanAwal: kecAwalyey, sudutTembak: sudutFirst, gravitasi: gravitasiVektor, ketinggian: ketinggianReal)
//
//
//
//        if let gameScene = skView.scene as? SpriteScene {
//            gameScene.initialY = gameScene.size.height * 0.5 + CGFloat(ketinggianEngine)
//            gameScene.totalWaktuEngine = totalWaktuEngine
//            gameScene.totalWaktuReal = totalWaktuReal
//            gameScene.ketinggianReal = ketinggianReal
//            gameScene.ketinggianEngine = ketinggianEngine
//        }
//
//    }
//
//    @IBAction func sudutUhuy(_ sender: UISlider) {
//        sudutFirstDummy = Double(sender.value)
//        if sudutFirstDummy < 90 {
//            sudutFirst = sudutFirstDummy
//        } else {
//            sudutFirst = 89.99999
//        }
//
//        totalWaktuEngine = engine.waktuUntukJarakTerjauhEngine(kecepatanAwal: kecAwalyey, sudutTembak: sudutFirst, gravitasi: gravitasiVektor, ketinggian: ketinggianEngine)
//        totalWaktuReal = engine.waktuUntukJarakTerjauhReal(kecepatanAwal: kecAwalyey, sudutTembak: sudutFirst, gravitasi: gravitasiVektor, ketinggian: ketinggianReal)
//
//        if let gameScene = skView.scene as? SpriteScene {
//            gameScene.sudutTembakScene = sudutFirst
//            gameScene.totalWaktuEngine = totalWaktuEngine
//            gameScene.totalWaktuReal = totalWaktuReal
//        }
//    }
//
//
//    @IBAction func sliderUhuy(_ sender: UISlider) {
//        kecAwalyey = Float(sender.value * kecMax)
//
//        totalWaktuEngine = engine.waktuUntukJarakTerjauhEngine(kecepatanAwal: kecAwalyey, sudutTembak: sudutFirst, gravitasi: gravitasiVektor, ketinggian: ketinggianEngine)
//        totalWaktuReal = engine.waktuUntukJarakTerjauhReal(kecepatanAwal: kecAwalyey, sudutTembak: sudutFirst, gravitasi: gravitasiVektor, ketinggian: ketinggianReal)
//        settingsTableView.reloadData()
//
//        if let gameScene = skView.scene as? SpriteScene {
//            gameScene.totalWaktuEngine = totalWaktuEngine
//            gameScene.totalWaktuReal = totalWaktuReal
//            gameScene.kecAwalScene = kecAwalyey
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
//            if waktuRealtime < totalWaktuReal {
//                kecepatanXReal = Float(engine.kecepatanXAwalReal(sudutTembak: sudutFirst, kecepatanAwal: kecAwalyey))
//                kecepatanYReal = Float(engine.kecepatanY(sudutTembak: sudutFirst, kecepatanAwal: kecAwalyey, waktu: waktuRealtime, gravitasi: gravitasiVektor))
//
//                let kecepatanXKuadrat = pow(kecepatanXReal, 2)
//                let kecepatanYKuadrat = pow(kecepatanYReal,2)
//                kecTotal = pow(kecepatanXKuadrat + kecepatanYKuadrat, 0.5)
//            } else {
//                kecepatanXReal = 0
//                kecepatanYReal = 0
//                kecTotal = 0
//            }
//
//
//            let posisiY = engine.yProyektilTerhadapWaktuEngine(kecepatanAwal: kecAwalyey, sudutTembak: sudutFirst, waktu: waktuEngine, gravitasi: gravitasiVektor)
//
//            posisiYRealTime = Float(engine.yProyektilTerhadapWaktuReal(kecepatanAwal: kecAwalyey, sudutTembak: sudutFirst, waktu: waktuRealtime, gravitasi: gravitasiVektor))
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
//                    kecTotal = gameScene.getKecepatanTotal()
//                    kecepatanXReal = gameScene.getKecepatanXReal()
//                    kecepatanYReal = gameScene.getKecepatanYReal()
//
//
//                } else if gameScene.jarakXRealtime > gameScene.jarakXMaxReal {
//                    posisiXRealTime = gameScene.jarakXMaxReal
//                    waktuRealtime = gameScene.totalWaktuReal
//                    kecTotal = 0
//                    kecepatanXReal = 0
//                    kecepatanYReal = 0
//                    if ketinggianReal == 0 {
//                        posisiYRealTime = 0
//                    } else {
//                        posisiYRealTime = -ketinggianReal
//                    }
//
//                }
//            }
//            settingsTableView.reloadData()
//        }
//    }
//}
//
//
//
//
//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
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
//            cell.textLabel?.text = "Kec X"
//            cell.detailTextLabel?.text = String(round(kecepatanXReal * 100)/100)
//            return cell
//        case 6:
//            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//            cell.textLabel?.text = "Kec Y"
//            cell.detailTextLabel?.text = String(round(kecepatanYReal * 100)/100)
//            return cell
//        case 7:
//            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//            cell.textLabel?.text = "Kec Total"
//            cell.detailTextLabel?.text = String(round(kecTotal * 100) / 100)
//            return cell
//        case 8:
//            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//            cell.textLabel?.text = "Sudut"
//            cell.detailTextLabel?.text = String(round(sudutFirstDummy * 100)/100)
//            return cell
//        case 9:
//            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//            cell.textLabel?.text = "Ketinggian"
//            cell.detailTextLabel?.text = String(round(ketinggianReal * 100)/100)
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
