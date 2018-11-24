//
//  StringExtension.swift
//  TablePlus-iOS
//
//  Created by Son on 11/24/18.
//  Copyright © 2018 TablePlus. All rights reserved.
//

import UIKit

extension String {
    static var unique: String {
        return "\(Date().timeIntervalSince1970)\(arc4random())"
    }
}
