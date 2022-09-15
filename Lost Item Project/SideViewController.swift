//
//  SideViewController.swift
//  Lost Item Project
//
//  Created by Hei Lok Keith Kong on 13/9/2022.
//

import UIKit

class SideViewController: UIViewController {

    @IBOutlet weak var menuView: UITableView!
    let menuItems = Action.allActions()
    let rowHeight:CGFloat = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuView.dataSource = self
        self.menuView.delegate = self
        self.menuView.separatorColor = .systemGray2
    }
}

extension SideViewController: UITableViewDataSource {
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    // height of each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    // content of each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.initializeActions(menuItems[indexPath.row])
        return cell
    }
    
    
}

// for future, if variables / data in this class depend on other classes
extension SideViewController: UITableViewDelegate {
    
}
