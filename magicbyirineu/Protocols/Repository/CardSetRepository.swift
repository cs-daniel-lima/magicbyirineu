//
//  CardSetRepository.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 28/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

protocol CardSetRepository {
    
    func fetchCardSets(completion: @escaping (Result<[CardSet]>) -> Void)
}
