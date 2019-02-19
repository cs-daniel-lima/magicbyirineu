//
//  SetsTableViewDataSource.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

class SetsTableViewDatasource: NSObject, UITableViewDataSource{
    
    init(tableView: UITableView) {
        super.init()
        setupTableView(tableView: tableView)
    }
    
    private func setupTableView(tableView: UITableView){
        tableView.register(SetTableViewCell.self, forCellReuseIdentifier: "setTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "setTableViewCell", for: indexPath) as? SetTableViewCell else {
            Logger.logError(in: self, message: "Error casting cell as SetTableViewCell")
            return UITableViewCell()
        }
        cell.setupCell()
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Creatures"
        case 1:
            return "Animals"
        default:
            return "This is a test"
        }
    }
    
    
    
    
}
