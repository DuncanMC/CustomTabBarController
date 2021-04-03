//
//  ViewController.swift
//  ShapeWithTab
//
//  Created by Duncan Champney on 4/1/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var shapeView: ShapeWithTabView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .darkGray
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.yellow.cgColor
    }

    override func viewDidLayoutSubviews() {
        shapeView.updateShapeLayerPath()
    }
}

