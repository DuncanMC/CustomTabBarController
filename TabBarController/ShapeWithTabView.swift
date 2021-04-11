//
//  ShapeWithTabView.swift
//  ShapeWithTab
//
//  Created by Duncan Champney on 4/1/21.
//

import UIKit

class ShapeWithTabView: UIView {

    var cornerRadius: CGFloat = 15
    var tabRadius: CGFloat = 70
    var bevelRadius: CGFloat = 50
    var tabExtent: CGFloat = 0

    var shapeLayer = CAShapeLayer()
    var maskLayer = CAShapeLayer()

    func buildShapeLayerPath() -> CGPath {
        let boxWidth = min(bounds.size.width - 40, 686)
        let boxHeight = min(bounds.size.height - 40 - tabRadius * 2 - tabExtent, 832)

        // These are the corners of the view's primary rectangle
        let point1 = CGPoint(x: 0, y: boxHeight)
        let point2 = CGPoint(x: 0, y: 0)
        let point3 = CGPoint(x: boxWidth, y: 0)
        let point4 = CGPoint(x: boxWidth, y: boxHeight)

        // These are the corners of the "tab" that extends outside the view's normal bounds.
        let tabPoint1 = CGPoint(x: boxWidth / 2 + tabRadius, y: boxHeight)
        let tabPoint2 = CGPoint(x: boxWidth / 2 + tabRadius, y: boxHeight + tabExtent + tabRadius + bevelRadius )
        let tabPoint3 = CGPoint(x: boxWidth / 2 - tabRadius, y: boxHeight + tabExtent + tabRadius + bevelRadius)
        let tabPoint4 = CGPoint(x: boxWidth / 2 - tabRadius , y: boxHeight)

        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: boxHeight - cornerRadius))
        path.addArc(tangent1End: point2,
                    tangent2End: point3,
                    radius: cornerRadius)
        path.addArc(tangent1End: point3,
                    tangent2End: point4,
                    radius: cornerRadius)
        path.addArc(tangent1End: point4,
                    tangent2End: point1,
                    radius: cornerRadius)
//
        path.addArc(tangent1End: tabPoint1,
                    tangent2End: tabPoint2,
                    radius: bevelRadius)
        path.addArc(tangent1End: tabPoint2,
                    tangent2End: tabPoint3,
                    radius: tabRadius)
        path.addArc(tangent1End: tabPoint3,
                    tangent2End: tabPoint4,
                    radius: tabRadius)
        path.addArc(tangent1End: tabPoint4,
                    tangent2End: point1,
                    radius: bevelRadius)

        path.addArc(tangent1End: point1,
                    tangent2End: point2,
                    radius: cornerRadius)

        return path
    }

    func doInitSetup() {
        self.layer.addSublayer(shapeLayer)
        self.layer.mask = maskLayer
        backgroundColor = .lightGray

        //Configure a shape layer to draw an outline
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 2

        //Configure a mask layer to mask the view to our custom shape
        maskLayer.fillColor = UIColor.white.cgColor
        maskLayer.strokeColor = UIColor.white.cgColor
        maskLayer.lineWidth = 2
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.doInitSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.doInitSetup()
    }
    public func updateShapeLayerPath() {
        let path = buildShapeLayerPath()
        shapeLayer.path =  path
        maskLayer.path = path
    }

    override var frame: CGRect {
        didSet {
            print("New frame = \(frame)")
            shapeLayer.frame = layer.bounds
        }
    }
}
