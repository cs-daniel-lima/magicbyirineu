//
//  SetsTableViewDelegate.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit
import SnapKit

class SetsTableViewDelegate: NSObject, UITableViewDelegate{
    
    var tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        let text = UILabel(frame: .zero)
        text.textColor = UIColor.white
        text.font = UIFont(name:"SFProDisplay-Bold", size: 38)
        text.text = tableView.dataSource?.tableView?(self.tableView, titleForHeaderInSection: section) ?? "Não foi 😱"
        view.addSubview(text)
        text.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.left.equalToSuperview().inset(15)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
