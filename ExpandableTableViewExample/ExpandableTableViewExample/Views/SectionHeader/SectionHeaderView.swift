//
//  SectionHeaderView.swift
//  ExpandableTableViewExample
//
//  Created by SAMER DABBAGH on 11/23/17.
//  Copyright © 2017 M.Kamran. All rights reserved.
//

import UIKit

protocol SectionTapDelegate: class {
    func onSectionTouched(_ index: Int)
}

class SectionHeaderView: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    
    // MARK: - Properties
    private var index = 0
    weak private var delegate: SectionTapDelegate?
    
    // MARK: - View's Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addGestureListenter()
    }
    
    // MARK: - Setup
    private func addGestureListenter() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func onTap() {
        self.delegate?.onSectionTouched(self.index)
    }
    
    // MARK: - Update UI
    public func configure(_ title: String, index: Int, delegate: SectionTapDelegate?) {
        self.index = index
        self.delegate = delegate
        self.titleLabel.text = title
    }
}

extension SectionHeaderView {
    
    /**
     Loading view form its nib file
     - returns: Optional SectionHeaderView created from the nib.
     */
    class func fromNib() -> SectionHeaderView?  {
        return Bundle.main.loadNibNamed("SectionHeaderView", owner: self, options: nil)?.first as? SectionHeaderView
    }
}


