//
//  CustomTabBar.swift
//  TabBarController
//
//  Created by Duncan Champney on 3/31/21.
//

import UIKit

class CustomTabBar: UITabBar {

    var maskLayer = CAShapeLayer()

    override var frame: CGRect {
        didSet {
            configureMaskLayer()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMaskLayer()
        self.layer.mask = maskLayer
        self.layer.borderWidth = 0
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureMaskLayer()
        self.layer.mask = maskLayer
    }

    func     configureMaskLayer() {
        let rect = layer.bounds
        maskLayer.frame = rect
        let circleBoxSize = rect.size.height * 1.25
        maskLayer.fillRule = .evenOdd
        let path = UIBezierPath(rect: rect)
        let circleRect = CGRect(x: rect.size.width/2 - circleBoxSize / 2,
                                y: -circleBoxSize/2,
                                width: circleBoxSize,
                                height: circleBoxSize)
        let circle = UIBezierPath.init(ovalIn: circleRect)
        path.append(circle)
        maskLayer.path = path.cgPath
        maskLayer.fillColor = UIColor.white.cgColor // Any opaque color works and has no effect
    }
}
