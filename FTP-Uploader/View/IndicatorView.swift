//
//  IndicatorView.swift
//  FTP-Uploader
//
//  Created by Golos on 3/10/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import UIKit

class IndicatorView: UIView {
    
    private lazy var indicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.stopAnimating()
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private lazy var label: UILabel = {
        let indicatorLabel = UILabel()
        indicatorLabel.translatesAutoresizingMaskIntoConstraints = false
        indicatorLabel.textAlignment = .center
        indicatorLabel.textColor = .gray
        indicatorLabel.numberOfLines = 0
        indicatorLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        return indicatorLabel
    }()
    
    var labelText: String? {
        didSet {
            label.text = labelText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    convenience init(view: UIView) {
        self.init(view: view, text: nil)
    }
    
    convenience init(view: UIView, text: String?) {
        self.init(frame: .zero)
        
        labelText = text
        isHidden = true
        
        view.addSubview(self)
        view.bringSubviewToFront(self)
        view.addFullscreenConstraints(for: self)
    }
    
    private func setup() {
        addSubview(indicator)
        addSubview(label)
        
        indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        label.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 10).isActive = true
        label.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        label.centerXAnchor.constraint(equalTo: indicator.centerXAnchor).isActive = true
        
        backgroundColor = UIColor(white: 0.5, alpha: 0.4)
    }
    
    var isLoading: Bool = false {
        didSet {
            isHidden = !isLoading
            isLoading ? indicator.startAnimating() : indicator.stopAnimating()
        }
    }
}
