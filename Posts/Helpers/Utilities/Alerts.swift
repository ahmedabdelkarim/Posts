//
//  Alerts.swift
//

import Foundation
import UIKit

class Alerts {
    
    typealias AlertAction = () -> Void
    private static let accentColor = UIColor(named: "AccentColor")
    
    /// Show a simple info alert over a specific presented view controller.
    static func showInfoAlert(viewController: UIViewController?, title: String, message: String? = nil, completion: AlertAction? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.view.tintColor = accentColor
            
            viewController?.present(alert, animated: true, completion: completion)
        }
    }
}
