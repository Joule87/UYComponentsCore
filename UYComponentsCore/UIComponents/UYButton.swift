//
//  UYButton.swift
//  UYComponentsCore
//
//  Created by Julio Collado on 5/26/21.
//

import UIKit

@IBDesignable
public class UYButton: UIButton {

    @IBInspectable public var isShiny: Bool = false {
        didSet {
            if isShiny {
                backgroundColor = .yellow
            } else {
                backgroundColor = .white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = 8
        setTitle("OK", for: .normal)
    }
    
}
