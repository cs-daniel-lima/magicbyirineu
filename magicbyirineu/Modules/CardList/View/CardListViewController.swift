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
    
    var tableViewDelegate: SetsTableViewDelegate!
    var tableViewDatasource: SetsTableViewDatasource!
    
    override func loadView() {
        super.loadView()
        self.view = screen
        self.setupTableView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }

}

//TableView and Collection Views
extension CardListViewController{
    
    func setupTableView(){
        tableViewDatasource = SetsTableViewDatasource(tableView: self.screen.setsTableView)
        tableViewDelegate = SetsTableViewDelegate()
        self.screen.setsTableView.delegate = self.tableViewDelegate
        self.screen.setsTableView.dataSource = self.tableViewDatasource
    }
    
}
