//
//  InputView.swift
//  ContactManager
//
//  Created by Effie on 1/14/24.
//

import UIKit

final class InputView: UIView {
    private let formatter: InputFormattable
    
    var currentValue: String {
        return self.textField.text ?? ""
    }
    
    private let fieldNamelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(self.fieldNamelabel)
        stack.addArrangedSubview(self.textField)
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(
        fieldName: String,
        keyboardType: UIKeyboardType,
        formatter: InputFormattable
    ) {
        self.formatter = formatter
        super.init(frame: .zero)
        textField.delegate = self
        configure(fieldName: fieldName, keyboardType: keyboardType)
        setupViews()
    }
    
    private func configure(fieldName: String, keyboardType: UIKeyboardType) {
        self.fieldNamelabel.text = fieldName
        self.textField.keyboardType = keyboardType
    }
    
    private func setupViews() {
        self.addSubview(self.hStack)
        NSLayoutConstraint.activate([
            self.hStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.hStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.hStack.topAnchor.constraint(equalTo: self.topAnchor),
            self.hStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.fieldNamelabel.heightAnchor.constraint(equalTo: self.textField.heightAnchor),
            self.textField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
        ])
    }
}

extension InputView: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let oldText = textField.text else { return false }
        guard string.isEmpty == false else { return true } // 지울 때
        let newText = NSString(string: oldText).replacingCharacters(in: range, with: string)
        textField.text = self.formatter.format(newText)
        return false
    }
}
