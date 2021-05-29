//
//  DisclamerView.swift
//  UYComponentsCore
//
//  Created by Julio Collado on 5/26/21.
//

import UIKit

@IBDesignable
public class DisclaimerView: UIView, NibOwnerLoadable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton! {
        didSet {
            acceptButton.setTitle("Agree", for: .normal)
            acceptButton.setTitleColor(.black, for: .normal)
            acceptButton.backgroundColor = .link
            acceptButton.layer.cornerRadius = 8
        }
    }
    
    @IBInspectable public var isVampireStyle: Bool = false {
        didSet {
            if isVampireStyle {
                backgroundColor = .black
                titleLabel.textColor = .red
                contentLabel.textColor = .red
                acceptButton.setTitleColor(.red, for: .normal)
                acceptButton.backgroundColor = .black
            } else {
                backgroundColor = .white
                titleLabel.textColor = .black
                contentLabel.textColor = .black
                acceptButton.setTitleColor(.black, for: .normal)
                acceptButton.backgroundColor = .link
            }
        }
    }
    
    @IBInspectable public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    @IBInspectable public var content: String? {
        didSet {
            contentLabel.text = content
        }
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
         self.loadNibContent()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNibContent()
    }
    
    public func setup(title: String?, content: String) {
        titleLabel.text = title
        contentLabel.text = content
    }
    
    
}


