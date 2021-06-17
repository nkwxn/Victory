//
//  PanduanLab.swift
//  victory
//
//  Created by Wuri Dita on 10/06/21.
//

import UIKit

class PanduanLabView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBAction func onCloseButtonPressed(_ sender: Any) {
        delegate?.closePanduanView()
    }
    weak var delegate: PraktikumBerpanduanViewControllerDelegate?
    /*
    // Init Functions
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
        return Constants.panduanLabs[0].langkah.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PanduanTableViewCell", for: indexPath) as?
                PanduanTableViewCell else { return UITableViewCell() }
        cell.setView(index: indexPath.row)
        return cell
    }
}
