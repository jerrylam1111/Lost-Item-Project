//
//  MenuActions.swift
//  Lost Item Project
//
//  Created by Hei Lok Keith Kong on 14/9/2022.
//

import UIKit

struct Action {
    let name: String
    let image: UIImage?
    
    init(name: String, image: UIImage?) {
        self.name = name
        self.image = image
    }
    
    static func allActions() -> [Action] {
        return [
        Action(name: "My Tickets", image: UIImage(systemName: "ticket")),
        Action(name: "Messages", image: UIImage(systemName: "message.badge")),
        Action(name: "Options", image: UIImage(systemName: "option")),
        Action(name: "Settings", image: UIImage(systemName:"wrench.and.screwdriver")),
        Action(name: "Account", image: UIImage(systemName: "person.circle"))
        ]
        }
}
