//
//  ReportStruct.swift
//  Lost Item Project
//
//  Created by Hei Lok Keith Kong on 14/9/2022.
//

import UIKit

struct Report {
    let item: String
    let date: Date?
    let location: String
    let description: String
    let reporter: String
    let image: UIImage?
    
    static func sampleReport() -> [Report] {
        return [
            Report(item: "iPhone 14 Pro Max", date: DateComponents(calendar:Calendar.current, year: 2022, month: 9, day: 14).date, location: "CLB7", description: "Red", reporter: "Anonymous", image: UIImage(named: "iPhone14"))
        ]
    }
}
