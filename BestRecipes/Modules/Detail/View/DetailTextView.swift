//
//  DetailTextView.swift
//  tests
//
//  Created by Pavel Kostin on 01.07.2024.
//
//
import UIKit


final class DetailText: UIView {
    
    private let verticalStack = UIStackView()
    private let instructionLabel = UILabel()
    private let textView = UITextView()
//    private let redText = UILabel()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupView()
        setupConstraint()
        setupConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}


private extension DetailText {
    
    func setupView() {
        addSubviews(verticalStack)
        verticalStack.addArrangedSubviews([instructionLabel, textView])
    }
    
    func setupConstraint() {
        
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: topAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setupConfigure() {
        
        verticalStack.axis = .vertical
        verticalStack.spacing = 6
        
        instructionLabel.text = "Instructions"
        instructionLabel.font = Font.getFont(.poppinsBold, size: 20)
        
        textView.font = Font.getFont(.poppinsRegular, size: 16)
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.lineFragmentPadding = 0

    }
}

extension DetailText {
    
    func updateInstructionText(with steps: [Step]) {
        let instructions = steps.compactMap { step -> String? in
            guard let number = step.number, let description = step.step else { return nil }
            return " \(number). \(description)"
        }
        textView.text = instructions.joined(separator: "\n")
    }
}
