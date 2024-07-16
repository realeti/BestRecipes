//
//  DetailText.swift
//  tests
//
//  Created by Pavel Kostin & realeti on 01.07.2024.
//
//
import UIKit

final class DetailText: UIView {
    // MARK: - UI
    private let verticalStack = UIStackView(
        axis: .vertical,
        spacing: 6,
        distribution: .fill
    )
    
    private let instructionsLabel = UILabel(
        text: K.instructions,
        color: .black,
        font: .poppinsBold,
        fontSize: 20.0
    )
    
    private lazy var textView: UITextView = {
        let view = UITextView()
        view.textColor = .black
        view.backgroundColor = .clear
        view.font = Font.getFont(.poppinsRegular, size: 16)
        view.textContainerInset = UIEdgeInsets.zero
        view.textContainer.lineFragmentPadding = 0
        view.isSelectable = true
        view.isEditable = false
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Set Views
    func setupView() {
        addSubview(verticalStack)
        verticalStack.addArrangedSubviews([instructionsLabel, textView])
    }
}

// MARK: - Setup Constraints
private extension DetailText {
    func setupConstraint() {
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: topAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - Update Text View
extension DetailText {
    /*func updateInstructionText(with steps: [Step]) {
        let instructions = steps.compactMap { step -> String? in
            guard let number = step.number, let description = step.step else { return nil }
            return "  \(number + 1). \(description)"
        }
        textView.text = instructions.joined(separator: "\n")
    }*/
    
    func updateInstructionText(with instruction: [String: String]) {
        let sortedInstructions = instruction.sorted(by: <)
        
        /// create text by string dictionary
        let instuructionText = sortedInstructions.reduce(into: "") { resultText, element in
            let (key, value) = element
            resultText += "\(key). " + "\(value)\n"
        }.trimmingCharacters(in: .whitespacesAndNewlines)
        
        /// create paragraphs
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.defaultTabInterval = 15
        paragraphStyle.headIndent = 15
        
        let attributedString = NSMutableAttributedString(
            string: instuructionText,
            attributes: [
                .paragraphStyle: paragraphStyle,
                .font: Font.getFont(.poppinsRegular, size: 16),
                .foregroundColor: UIColor.black
            ]
        )
        
        /// create red string
        let redAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.redLight,
            .font: Font.getFont(.poppinsRegular, size: 16)
        ]
        let redString = NSAttributedString(string: K.stepRed, attributes: redAttributes)
        
        /// Add a new line before the red text
        attributedString.append(NSAttributedString(string: "\n"))
        attributedString.append(redString)
        
        textView.attributedText = attributedString
    }
}
