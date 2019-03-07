//
//  Repository.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 28/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

protocol CardRepository {
    
    func fetchCards(page:Int?, name:String?, setCode:String?, type:String?, completion: @escaping (Result<[Card]>, Int?) -> Void)
}
