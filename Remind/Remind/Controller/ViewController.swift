//
//  ViewController.swift
//  Remind
//
//  Created by Daniel Alejandro Carriola on 3/23/18.
//  Copyright © 2018 Daniel Alejandro Carriola. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call services
        UNService.shared.authotize()
        CLService.shared.authotize()
        
        // Add observers
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterRegion), name: NSNotification.Name("internalNotification.enteredRegion"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleAction(_:)), name: NSNotification.Name("internalNotification.handleAction"), object: nil)
    }
    
    @objc func didEnterRegion() {
        UNService.shared.locationRequest()
    }
    
    @objc func handleAction(_ notification: Notification) {
        guard let action = notification.object as? NotificationActionID else { return }
        switch action {
        case .timer: print("Timer logic")
        case .date: print("Date logic")
        case .location: changeBackground()
        }
    }
    
    func changeBackground() {
        view.backgroundColor = .red
    }

    @IBAction func onTimerTapped(_ sender: Any) {
        print("Timer")
        AlertService.actionSheet(in: self, title: "5 seconds") {
            UNService.shared.timerRequest(with: 5)
        }
    }
    
    @IBAction func onDateTapped(_ sender: Any) {
        print("Date")
        AlertService.actionSheet(in: self, title: "Some future time") {
            var components = DateComponents()
            components.second = 0
            UNService.shared.dateRequest(with: components)
        }
    }
    
    @IBAction func onLocationTapped(_ sender: Any) {
        print("Location")
        AlertService.actionSheet(in: self, title: "When I return") {
            CLService.shared.updateLocation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

