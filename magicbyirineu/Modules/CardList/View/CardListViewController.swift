//
//  CardListViewController.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

enum Status {
    case normal
    case empty
}

class CardListViewController: UIViewController {
    
    
    var presenter:CardListPresenter!
    let screen = CardListView()
    
    required init(title:String){
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func set(status: Status){
        
        switch status {
        case .normal:
            self.screen.emptySearchLabel.isHidden = true
        case .empty:
            self.screen.emptySearchLabel.isHidden = false
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        screen.searchBar.additionalSetupAfterDisplay()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
}
