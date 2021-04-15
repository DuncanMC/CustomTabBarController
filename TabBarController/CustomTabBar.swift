//
//  CustomTabBar.swift
//  TabBarController
//
//  Created by Duncan Champney on 3/31/21.
//

import UIKit

class CustomTabBar: UITabBar {

    var maskLayer = CAShapeLayer()

    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let newHeight = max(size.height, 100)
        return CGSize(width: size.width, height: newHeight)
    }

    override var frame: CGRect {
        didSet {
            configureMaskLayer()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
//        configureMaskLayer()
        self.layer.mask = maskLayer
        self.layer.borderWidth = 0
        clipsToBounds = false
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureMaskLayer()
        self.layer.mask = maskLayer
    }

    func tabBarMaskPath() -> CGPath? {
        let width = bounds.width
        let height = bounds.height
        guard width > 0 && height > 0 else { return nil }
        let dentRadius: CGFloat = 35
        let cornerRadius: CGFloat = 20
        let topFlatPartWidth = (width - dentRadius * 2.0) / 2
        let polygonPoints = [
            PolygonPoint(point: CGPoint(x:  0, y:  0),                                                          // Point 0
                         isRounded: true,
                         customCornerRadius: cornerRadius),
            PolygonPoint(point: CGPoint(x:  0, y:  height),                                                     // Point 1
                         isRounded: false),
            PolygonPoint(point: CGPoint(x:  width, y:  height),                                                 // Point 2
                         isRounded: false),
            PolygonPoint(point: CGPoint(x:  width, y:  0),                                                      // Point 3
                         isRounded: true,
                         customCornerRadius: cornerRadius),
            PolygonPoint(point: CGPoint(x:  topFlatPartWidth + dentRadius * 2, y:  0),                          // Point 4
                         isRounded: true,
                         customCornerRadius: cornerRadius),
            PolygonPoint(point: CGPoint(x:  topFlatPartWidth + dentRadius * 2, y:  dentRadius + cornerRadius),  // Point 5
                         isRounded: true,
                         customCornerRadius: dentRadius),
            PolygonPoint(point: CGPoint(x:  topFlatPartWidth , y:  dentRadius  + cornerRadius),                  // Point 6
                         isRounded: true,
                         customCornerRadius: dentRadius),
            PolygonPoint(point: CGPoint(x:  topFlatPartWidth , y:  0),                                           // Point 7
                         isRounded: true,
                         customCornerRadius: cornerRadius),
        ]
        return buildPolygonPathFrom(points: polygonPoints, defaultCornerRadius: 0)
    }

    func     configureMaskLayer() {
        let rect = bounds
        let maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.fillRule = .evenOdd
        if let path = tabBarMaskPath() {
            maskLayer.path = path
            maskLayer.fillColor = UIColor.white.cgColor // Any opaque color works and has no effect
            layer.mask = maskLayer
        }
    }
}
