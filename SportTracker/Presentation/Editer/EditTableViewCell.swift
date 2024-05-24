//
//  EditTableViewCell.swift
//  SportTracker
//
//  Created by Вадим Амбарцумян on 18.05.2024.
//

import Foundation

import Foundation
import UIKit

class EditTableViewCell: UITableViewCell {
    
    private let label = UILabel()
    private let textField = UITextField()
    private var onUpdate: ((String) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        label.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let stackView = UIStackView(arrangedSubviews: [label, textField])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: (label: String, value: String), onUpdate: @escaping (String) -> Void) {
        label.text = data.label
        textField.text = data.value
        self.onUpdate = onUpdate
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        onUpdate?(textField.text ?? "")
    }
}
