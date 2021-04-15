//
//  ViewController.swift
//  ShapeWithTab
//
//  Created by Duncan Champney on 4/1/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .cyan
    }

    override func viewDidLayoutSubviews() {
        if let view = self.view as? ShapeWithTabView {
            view.updateShapeLayerPath()
        }
    }
}

