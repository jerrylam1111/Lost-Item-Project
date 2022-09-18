//
//  ReportCell.swift
//  Lost Item Project
//
//  Created by Hei Lok Keith Kong on 14/9/2022.
//

import UIKit

class ReportCell: UITableViewCell {
    
    
    @IBOutlet weak var reportItem: UILabel!
    @IBOutlet weak var reportDate: UILabel!
    @IBOutlet weak var reportLocation: UILabel!
    @IBOutlet weak var reportDescription: UILabel!
    @IBOutlet weak var reportReporter: UILabel!
    
    @IBOutlet weak var reportImage: UIImageView!
    
    let margin:CGFloat = -4
    
    let dateFormatter = DateFormatter()
    
    func sampleReport(_ report:Report) {
        reportImage.image = report.image?.withAlignmentRectInsets(UIEdgeInsets(top: margin, left: margin * 4, bottom: margin, right: margin))
        reportItem.text = "Item: " + report.item
        reportDate.text = "Date: " + formatDate(dateFormatter: dateFormatter, report: report)
        reportLocation.text = "Location: " + report.location
        reportDescription.text = "Description: " + report.description
        reportReporter.text = "Reporter: " + report.reporter
    }
    
    private func formatDate(dateFormatter:DateFormatter, report:Report) -> String {
        // British English Locale (en_GB)
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd") // set template after setting locale
        return dateFormatter.string(from: report.date!)
    }
}
