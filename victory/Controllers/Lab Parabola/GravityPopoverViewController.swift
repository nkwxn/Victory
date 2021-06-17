//
//  GravityPopoverViewController.swift
//  victory
//
//  Created by Nicholas on 11/06/21.
//

import UIKit

enum Planet: String {
    case earth = "Bumi"
    case moon = "Bulan"
    case mars = "Mars"
    case jupiter = "Jupiter"
    
    func getGravityValue() -> Double {
        switch self {
        case .earth:
            return 10
        case .moon:
            return 2
        case .mars:
            return 4
        case .jupiter:
            return 25
        }
    }
}

class GravityPopoverViewController: UITableViewController {
    let chosenPlanet: Planet? = nil
    var parentTable: UITableView?
    var parentIndexPath: IndexPath?
    let planets: [Planet] = [.earth, .moon, .mars, .jupiter]
    var delegate: GravityPopoverDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return planets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let planet = planets[indexPath.row]
        let cell = CustomClearTabl(image: nil, title: planet.rawValue, detail: "\(planet.getGravityValue()) m/s²", showAcc: false)

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Chosen planet: \(planets[indexPath.row])")
        // Should dismiss
        parentTable?.deselectRow(at: parentIndexPath!, animated: true)
        self.delegate?.chooseGravity(chosenValue: self.planets[indexPath.row])
        self.dismiss(animated: true)
    }
}

protocol GravityPopoverDelegate {
    func chooseGravity(chosenValue planet: Planet)
}
