//
//  ShapeWithTabView.swift
//  ShapeWithTab
//
//  Created by Duncan Champney on 4/1/21.
//

import UIKit

class ShapeWithTabView: UIView {

    var cornerRadius: CGFloat = 15
    var tabRadius: CGFloat = 30
    var bevelRadius: CGFloat = 20
    var tabExtent: CGFloat = 10

    var shapeLayer = CAShapeLayer()
    var maskLayer = CAShapeLayer()

    func buildShapeLayerPath() -> CGPath {
        let boxWidth = bounds.size.width
        let boxHeight = bounds.size.height - 40 - tabRadius * 2 - tabExtent

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

        //Create an array of PolygonPoints that we can use to build a mask path for our view
        let points = [
            PolygonPoint(point: point1, isRounded: true, customCornerRadius: cornerRadius),
            PolygonPoint(point: point2, isRounded: true, customCornerRadius: cornerRadius),
            PolygonPoint(point: point3, isRounded: true, customCornerRadius: cornerRadius),
            PolygonPoint(point: point4, isRounded: true, customCornerRadius: cornerRadius),
            PolygonPoint(point: tabPoint1, isRounded: true, customCornerRadius: bevelRadius),
            PolygonPoint(point: tabPoint2, isRounded: true, customCornerRadius: tabRadius),
            PolygonPoint(point: tabPoint3, isRounded: true, customCornerRadius: tabRadius),
            PolygonPoint(point: tabPoint4, isRounded: true, customCornerRadius: bevelRadius),
                      ]

        //Build our mask path
        let path = buildPolygonPathFrom(points: points, defaultCornerRadius: 20)

        return path
    }

    func doInitSetup() {
        self.layer.addSublayer(shapeLayer)
        self.layer.mask = maskLayer
        backgroundColor = .lightGray

        //Configure a shape layer to draw an outline
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
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
