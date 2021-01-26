//
//  PriceLabel.swift
//  Bice
//
//  Created by silly b on 2021/1/26.
//

import Cocoa

class PriceLabel: NSView {
    
    private lazy var text: NSText = {
        let v = NSText()
        v.backgroundColor = .orange
        v.isEditable = false
        v.isSelectable = false
        v.font = .systemFont(ofSize: 10)
        v.alignment = .right
        return v
    }()
            
    var price: String? {
        didSet {
            if let v = price {
                text.string = v
            } else {
                text.string = "-: -"
            }
        }
    }
    
    enum PriceLabelFontSize {
        case normal
        case small
    }
    
//    var fontSize: PriceLabelFontSize = .normal {
//        didSet {
//            if fontSize == .small {
//                priceLabel.font = .systemFont(ofSize: 8)
//            } else if fontSize == .normal {
//                priceLabel.font = .systemFont(ofSize: 12)
//            }
//        }
//    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        addSubview(text)
        text.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[t]-0-|", options: .init(), metrics: nil, views: ["t": text]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[t(40)]", options: .init(), metrics: nil, views: ["t": text]))
//        addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: text, attribute: .centerY, multiplier: 1.0, constant: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: NSPoint) -> NSView? {
        return self
    }

}
