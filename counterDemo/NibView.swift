//
//  NibView.swift
//  IOS Tablekit framework
//
//  Created by Chanon Latt on 6/4/22.
//

import UIKit

class NibView: UIView {
    
    var contentView: UIView?
    
    func commitUI() {
        
    }
    
    private func loadViewFromNib() {
        if let className = NSStringFromClass(classForCoder)
            .components(separatedBy: ".")
            .last,
           let loadedView = Bundle.main
            .loadNibNamed(className, owner: self, options: nil)?
            .first as? UIView {
            loadedView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(loadedView)
            NSLayoutConstraint.activate([
                loadedView.topAnchor.constraint(equalTo: topAnchor),
                loadedView.leadingAnchor.constraint(equalTo: leadingAnchor),
                loadedView.trailingAnchor.constraint(equalTo: trailingAnchor),
                loadedView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            contentView = loadedView
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
        commitUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViewFromNib()
        commitUI()
    }
}
