//
//  AlertService.swift
//  Remind
//
//  Created by Daniel Alejandro Carriola on 3/23/18.
//  Copyright © 2018 Daniel Alejandro Carriola. All rights reserved.
//

import UIKit

class AlertService {
    // Init
    private init() {}
    
    static func actionSheet(in vc: UIViewController, title: String, _ completion: @escaping () -> ()) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: title, style: .default) { (_) in
            completion()
        }
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
}
