//
//  ViewController.swift
//  UYComponentsCoreDemo
//
//  Created by Julio Collado on 5/10/21.
//

import UIKit
import UYComponentsCore

class ViewController: UIViewController {
    
    @IBOutlet weak var disclamerView: DisclaimerView! {
        didSet {
           disclamerView.setup(title: "Framework Demo", content: "This framework rocks!")
        }
    }
    @IBOutlet weak var okButton: UYButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let h = HelloManager()
        h.sayHello()
    }
    
    
}

