//
//  TableViewController.swift
//  FTP-Uploader
//
//  Created by Golos on 3/3/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    struct Props {
        let isLoading: Bool
    }
    
    private var tableModel: ViewContainable
    private var props = Props(isLoading: false) {
        didSet {
            indicatorView.isLoading = props.isLoading
        }
    }
    
    private lazy var indicatorView: IndicatorView = {
        let indicatorView = IndicatorView(view: self.view, text: NSLocalizedString("Loading", comment: ""))
        return indicatorView
    }()
    
    init(tableModel: ViewContainable) {
        self.tableModel = tableModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableModel.view)
        view.addFullscreenConstraints(for: tableModel.view)
    }
}

extension TableViewController {
    
    func render(props: Props) {
        self.props = props
    }
}

// MARK: - UISplitViewControllerDelegate
extension TableViewController: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
