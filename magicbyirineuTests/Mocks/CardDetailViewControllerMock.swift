//
//  DetailViewControllerMock.swift
//  magicbyirineuTests
//
//  Created by andre.antonio.filho on 28/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

@testable import magicbyirineu

class CardDetailViewControllerMock: CardDetailViewController {
    override func loadView() {
        super.loadView()
        self.view = screen
        self.screen.dismissButton.addTarget(self, action: #selector(self.dismissButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @objc override func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
