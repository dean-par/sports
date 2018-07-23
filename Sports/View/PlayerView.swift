//
//  PlayerView.swift
//  Sports
//
//  Created by Dean Parreno on 24/7/18.
//  Copyright © 2018 DeanParreno. All rights reserved.
//

import UIKit

class PlayerView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var headshotImage: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var detailTextLabel: UILabel!
    @IBOutlet weak var subtitleTextLabel: UILabel!
    @IBOutlet weak var subDetailTextLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("PlayerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}
