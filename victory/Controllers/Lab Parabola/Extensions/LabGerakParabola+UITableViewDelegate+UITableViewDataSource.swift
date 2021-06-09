//
//  LabGerakParabola+UITableViewDelegate+UITableViewDataSource.swift
//  victory
//
//  Created by Nicholas on 09/06/21.
//

import UIKit

extension LabGerakParabolaView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Isi headerview tergantung context
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "VarHeader") as! LabVariableHeaderView
        headerView.lblHeaderTitle.text = "Variabel"
        headerView.btnHeader.setTitle("X", for: .normal)
        return headerView
    }
    
    // Jumlah tergantung section dan context
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // Cell tergantung section dan context
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Cell"
        return cell
    }
}
