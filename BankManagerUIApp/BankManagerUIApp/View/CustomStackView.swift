//
//  HorizontalStackView.swift
//  BankManagerUIApp
//
//  Created by 릴라, Rowan on 2023/03/13.
//

import UIKit

final class HorizontalStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureProperties()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureProperties() {
        self.distribution = .fillEqually
        self.axis = .horizontal
    }

}

final class VerticalStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureProperties()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureProperties() {
        self.distribution = .fillEqually
        self.axis = .vertical
        self.spacing = 8
    }
}
