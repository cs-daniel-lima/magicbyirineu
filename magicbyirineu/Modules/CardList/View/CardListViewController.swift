//
//  CardListViewController.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

class CardListViewController: UIViewController {
    
    var presenter:CardListPresenter!
    let screen = CardListView()
    
    override func loadView() {
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }

}
