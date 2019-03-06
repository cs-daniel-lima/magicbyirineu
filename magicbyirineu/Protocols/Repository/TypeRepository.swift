//
//  TypeRepository.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 28/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

protocol TypeRepository {
    
    func fetchTypes(completion: @escaping (Result<[String]>) -> Void)
}
