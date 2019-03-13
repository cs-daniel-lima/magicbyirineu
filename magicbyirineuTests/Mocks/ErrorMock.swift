//
//  ErroMock.swift
//  magicbyirineuTests
//
//  Created by kaique.magno.santos on 13/03/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

class ErrorMock: Error {
    var localizedDescription: String {
        return "Test got an error"
    }
}
