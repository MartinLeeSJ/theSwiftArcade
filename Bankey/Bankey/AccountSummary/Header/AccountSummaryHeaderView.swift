//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by Martin on 2023/05/24.
//

import UIKit

class AccountSummaryHeaderView: UIView {
    @IBOutlet var contentView: UIView!
    let shakyBellView = ShakyBellView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    
    private func commonInit() {
        let bundle = Bundle(for: AccountSummaryHeaderView.self)
        bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
        addSubview(contentView)
        
        contentView.backgroundColor = appColor
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        setupShakyBell()
    }
    
    private func setupShakyBell() {
        shakyBellView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shakyBellView)
        NSLayoutConstraint.activate([
            shakyBellView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shakyBellView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
