//
//  CustomTabBar.swift
//  BestRecipes
//
//  Created by realeti on 01.07.2024.
//

import UIKit

protocol CustomTabBarProtocol: AnyObject {
    func createRecipeButtonPressed()
}

final class CustomTabBar: UITabBar {
    // MARK: - UI
    private var shapeLayer: CALayer?
    private let createRecipeButton = PlusButton(type: .system)
    
    // MARK: - Public Properties
    weak var tabBarController: CustomTabBarProtocol?
    
    // MARK: - Public Properties
    weak var tabBarController: UITabBarController?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        configureUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        configureShape()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTabBarItems()
    }
    
    // MARK: - Set Views
    private func setupUI() {
        addSubview(createRecipeButton)
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        createRecipeButton.addTarget(self, action: #selector(createRecipeButtonPressed), for: .touchUpInside)
    }
}

// MARK: - Configure Shape
extension CustomTabBar {
    private func configureShape() {
        let shapeLayer = TabBarShape(size: frame.size)
        
        if let oldShapeLayer = self.shapeLayer {
            oldShapeLayer.removeFromSuperlayer()
        }
        
        self.layer.insertSublayer(shapeLayer, at: 0)
        self.shapeLayer = shapeLayer
    }
}

// MARK: - Layout TabBar items
extension CustomTabBar {
    private func layoutTabBarItems() {
        // array with view controllers only
        let tabBarItems = subviews.filter { $0 is UIControl && $0 != createRecipeButton }
        
        guard tabBarItems.count == 4 else {
            fatalError("This layout assumes exactly 4 tab bar items")
        }
        
        let center = bounds.width / 2
        let itemWidth = Metrics.itemWidth
        let itemSpacing = Metrics.itemSpacing
        let itemTopIndent = Metrics.itemTopIndent
        
        var xOffset = center - (itemWidth * 2) - (itemSpacing * 2) - itemWidth
        
        for index in tabBarItems.indices {
            if index == 2 {
                xOffset = center + itemWidth + itemSpacing
            }
            
            // set frame for tabBar item
            tabBarItems[index].frame = CGRect(x: xOffset, y: itemTopIndent, width: itemWidth, height: itemWidth)
            xOffset += itemWidth + itemSpacing
        }
    }
}

// MARK: - Setup Constraints
extension CustomTabBar {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            createRecipeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            createRecipeButton.centerYAnchor.constraint(equalTo: topAnchor, constant: Metrics.plusButtonTopIndent),
            createRecipeButton.heightAnchor.constraint(equalToConstant: Metrics.plusButtonSize),
            createRecipeButton.widthAnchor.constraint(equalToConstant: Metrics.plusButtonSize)
        ])
    }
}

// MARK: - Actions
extension CustomTabBar {
    @objc private func createRecipeButtonPressed(_ sender: UIButton) {
        print("click plus button")
        tabBarController?.createRecipeButtonPressed()
    }
}

// MARK: - Hit test
extension CustomTabBar {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        createRecipeButton.frame.contains(point) ? createRecipeButton : super.hitTest(point, with: event)
    }
}

// MARK: - Metrics
fileprivate struct Metrics {
    static let plusButtonTopIndent: CGFloat = 10.0
    static let plusButtonSize: CGFloat = 48.0
    
    static let itemWidth: CGFloat = 40.0
    static let itemSpacing: CGFloat = 24.0
    static let itemTopIndent: CGFloat = 12.0
    
    private init () {}
}
