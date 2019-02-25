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
        self.setupTableView()
        
    }
    
    override func viewDidLoad() {
        screen.searchBar.delegate = presenter
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        screen.searchBar.additionalSetupAfterDisplay()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }

}

//TableView and Collection Views
extension CardListViewController{
    
    func setupTableView(){
        tableViewDatasource = SetsTableViewDatasource(tableView: self.screen.setsTableView)
        tableViewDelegate = SetsTableViewDelegate(tableView: self.screen.setsTableView)
        self.screen.setsTableView.delegate = self.tableViewDelegate
        self.screen.setsTableView.dataSource = self.tableViewDatasource
    }
    
}
