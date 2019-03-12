//
//  CardDetailViewController.swift
//  magicbyirineu
//
//  Created by andre.antonio.filho on 28/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit
import Kingfisher

class CardDetailViewController: MagicViewController {
    
    var card: Card?
    var presenter: CardDetailPresenter!
    var screen = CardDetailScreen()
    
    override func loadView() {
        super.loadView()
        
        
        if let urlString = card?.imageUrl {
            let url = URL(string: urlString)
            screen.cardImage.kf.setImage(with: url)
        }else{
            
            if let foreignNames = card?.foreignNames, foreignNames.count > 0  {
                    if let foreignImageUrl = foreignNames[0].imageUrl {
                        let url = URL(string: foreignImageUrl)
                        screen.cardImage.kf.setImage(with: url)
                    }
            }else{
                screen.cardImage.image = UIImage(named: "cartaVerso")
                screen.isHidden = false
                screen.cardName.text = self.card?.name
            }
        }
        
        self.view = screen
        self.screen.dismissButton.addTarget(self, action: #selector(self.dismissButtonTapped), for: .touchUpInside)
        self.screen.favoriteButton.addTarget(self, action: #selector(self.favoriteButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissButtonTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func favoriteButtonTapped(){
        switch self.screen.favoriteButton.isFavorite {
        case true:
            self.screen.favoriteButton.setAsNotFavorite()
        case false:
            self.screen.favoriteButton.setAsFavorite()
        }
    }
    
}
