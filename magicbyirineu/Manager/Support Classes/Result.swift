//
//  Result.swift
//  magicbyirineu
//
//  Created by kaique.magno.santos on 18/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}
