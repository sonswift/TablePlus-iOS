//
//  NoteSectionModel.swift
//  TablePlus-iOS
//
//  Created by Son on 11/24/18.
//  Copyright © 2018 TablePlus. All rights reserved.
//

import UIKit

class NoteSectionModel {
    var date: Date!
    var notes: [NoteModel]!
    init(date aDate: Date) {
        self.date = aDate
        self.notes = [NoteModel]()
    }
}
