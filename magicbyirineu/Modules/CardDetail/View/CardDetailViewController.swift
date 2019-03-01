//
//  CardDetailViewController.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 28/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit
import Kingfisher

class CardDetailViewController: UIViewController {
    
    var card: Card?
    var presenter: CardDetailPresenter!
    var screen = CardDetailScreen()

    override func loadView() {
        super.loadView()
        
        
        if let urlString = card?.imageUrl {
            let url = URL(string: urlString)
            screen.cardImage.kf.setImage(with: url)
        }else{
            Logger.logError(in: self, message: "Could not obtain image URL")
        }
        
        self.view = screen
        self.screen.dismissButton.addTarget(self, action: #selector(self.dismissButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissButtonTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    

}