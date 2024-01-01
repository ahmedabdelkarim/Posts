//
//  ViewController.swift
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.performSegue(withIdentifier: "showPosts", sender: self)
        })
    }

}
