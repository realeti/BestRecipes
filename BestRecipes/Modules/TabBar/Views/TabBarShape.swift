//
//  TabBarShape.swift
//  BestRecipes
//
//  Created by realeti on 02.07.2024.
//

import UIKit

protocol ShapeLayerProtocol: CAShapeLayer {
    init(size: CGSize)
}

extension ShapeLayerProtocol {
    init() {
        fatalError("init() cannot be used to create an instance.")
    }
}

final class TabBarShape: CAShapeLayer, ShapeLayerProtocol {
    init(size: CGSize) {
        super.init()
        
        path = createPath(with: size)
        
        lineWidth = 3.0
        strokeColor = UIColor.white.cgColor
        fillColor = UIColor.white.cgColor
        
        shadowOffset = CGSize(width: 0, height: -1)
        shadowRadius = 8
        shadowColor = UIColor.greyShadow.cgColor
        shadowOpacity = 1.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Create Bezier Path
extension TabBarShape {
    private func createPath(with size: CGSize) -> CGPath {
        let path = UIBezierPath()
        let centerWidth = size.width / 2
        let curveHeight = 42.0
        
        // Start point
        path.move(to: .zero)
        
        // Line to left curve start
        path.addLine(to: CGPoint(x: centerWidth - 54, y: 0))
        
        // Curve down
        path.addCurve(
            to: CGPoint(x: size.width / 2, y: curveHeight),
            controlPoint1: CGPoint(x: centerWidth - 30, y: 0),
            controlPoint2: CGPoint(x: centerWidth - 35, y: curveHeight)
        )
        
        // Curve up
        path.addCurve(
            to: CGPoint(x: (size.width / 2) + 54, y: 0),
            controlPoint1: CGPoint(x: centerWidth + 35, y: curveHeight),
            controlPoint2: CGPoint(x: centerWidth + 30, y: 0)
        )
        
        // Line to right curve end
        path.addLine(to: CGPoint(x: size.width, y: 0))
        
        // Right bottom line
        path.addLine(to: CGPoint(x: size.width, y: size.height))
        
        // Bottom line
        path.addLine(to: CGPoint(x: 0, y: size.height))
        
        // Close path
        path.close()
        
        return path.cgPath
    }
}
