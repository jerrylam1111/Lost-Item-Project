//
//  ListViewController.swift
//  Lost Item Project
//
//  Created by Hei Lok Keith Kong on 14/9/2022.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    let listItems = Report.sampleReport()
    let rowHeight:CGFloat = 175.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listTableView.dataSource = self
        self.listTableView.delegate = self
        self.listTableView.separatorColor = .systemGray2
    }
}

extension ListViewController: UITableViewDataSource {
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    // height of each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    // content of each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportCell", for: indexPath) as! ReportCell
        cell.sampleReport(listItems[indexPath.row])
        return cell
    }
}

// for future, if variables / data in this class depend on other classes
extension ListViewController: UITableViewDelegate {
    
}

