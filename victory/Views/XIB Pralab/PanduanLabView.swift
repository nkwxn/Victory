// swiftlint:disable trailing_whitespace
//
//  PanduanLab.swift
//  victory
//
//  Created by Wuri Dita on 10/06/21.
//

import UIKit

class PanduanViewController: UIViewController {
    var panduanLabArray: Int!
    
    override func viewDidLoad() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Initialize PanduanLabView
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        let panduanView = PanduanLabView(frame: frame, currentLab: panduanLabArray)
        panduanView.delegate = self
        self.view.addSubview(panduanView)
    }
}

extension PanduanViewController: PraktikumBerpanduanViewControllerDelegate {
    func moveToPanduanView() { }
    
    func closePanduanView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func changeStep(to step: Step) { }

    func startKuisView() { }
    
    func showSkorView(quizBrain: QuizBrain) { }
    
    func closeSkorView() { }
    
    func exitPraktikum() { }
    
    func showLabView() { }
    
}

class PanduanLabView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBAction func onCloseButtonPressed(_ sender: Any) {
        delegate?.closePanduanView()
        
    }
    weak var delegate: PraktikumBerpanduanViewControllerDelegate?
    var currentPanduanLab: Panduanlab!
    /*
    // Init Functions
    */
    
    init(frame: CGRect, currentLab: Int?) {
        super.init(frame: frame)
        guard let currentLab = currentLab else { return }
        currentPanduanLab = Constants.panduanLabs[currentLab]
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.currentPanduanLab = Constants.panduanLabs[0]
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.currentPanduanLab = Constants.panduanLabs[0]
        commonInit()
    }
    private func commonInit() {
        Bundle.main.loadNibNamed("PanduanLabView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setupTableView()
    }
}

extension PanduanLabView: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        let nib = UINib(nibName: "PanduanTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PanduanTableViewCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentPanduanLab.langkah.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PanduanTableViewCell", for: indexPath) as?
                PanduanTableViewCell else { return UITableViewCell() }
        cell.setView(index: indexPath.row, panduanLab: currentPanduanLab)
        return cell
    }
}
