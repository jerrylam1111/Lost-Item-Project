//
//  SideViewController.swift
//  Lost Item Project
//
//  Created by Hei Lok Keith Kong on 13/9/2022.
//

import UIKit

class SideViewController: UIViewController {

    @IBOutlet weak var menuView: UITableView!
    @IBOutlet weak var logOutView: UITableView!
    
    @IBOutlet weak var profilePicXPos: NSLayoutConstraint!
    @IBOutlet weak var profilePicWidth: NSLayoutConstraint!
    
    var delegate: sideViewControllerDelegate?
    
    let menuItems = Action.allActions()
    let logoutItems = Action.logoutAction()
    let rowHeight:CGFloat = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuView.dataSource = self
        self.menuView.delegate = self
        self.logOutView.dataSource = self
        self.logOutView.delegate = self
        self.menuView.separatorColor = .systemGray2
        self.logOutView.separatorColor = .systemGray2
    }
}

extension SideViewController: UITableViewDataSource {
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == menuView {
            return menuItems.count
        } else if tableView == logOutView {
            return 1
        } else {
            return 0
        }
    }
    
    // height of each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    // content of each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        if tableView == menuView {
            cell.initializeActions(menuItems[indexPath.row])
        } else if tableView == logOutView {
            cell.initializeActions(logoutItems[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == menuView {
            switch menuItems[indexPath.row].name {
            case "Home":
                delegate?.homeBtnPressed()
            case "My Tickets":
                delegate?.myTicketsBtnPressed()
            case "Messages":
                delegate?.messagesBtnPressed()
            case "Options":
                delegate?.optionsBtnPressed()
            case "Settings":
                delegate?.settingsBtnPressed()
            case "Account":
                delegate?.accountBtnPressed()
            default:
                break
            }
        } else if tableView == logOutView {
            if logoutItems[indexPath.row].name == "Logout" {
                delegate?.logoutBtnPressed()
            }
        }
    }
}


// for future, if variables / data in this class depend on other classes
extension SideViewController: UITableViewDelegate {
    
}

protocol sideViewControllerDelegate {
    func homeBtnPressed()
    func myTicketsBtnPressed()
    func messagesBtnPressed()
    func optionsBtnPressed()
    func settingsBtnPressed()
    func accountBtnPressed()
    func logoutBtnPressed()
}
