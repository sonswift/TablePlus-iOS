//
//  NoteModel.swift
//  TablePlus-iOS
//
//  Created by Son on 11/24/18.
//  Copyright © 2018 TablePlus. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class NoteModel: Object {
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var content = ""
    @objc dynamic var updatedDate = Date()

    override class func primaryKey() -> String? {
        return "id"
    }

    convenience init(title aTitle: String, content aContent: String) {
        self.init()
        self.id = String.unique
        self.title = aTitle
        self.content = aContent
    }

    convenience init(title aTitle: String, content aContent: String, createdTime: Date) {
        self.init(title: aTitle, content: aContent)
        self.updatedDate = createdTime
    }
}

extension NoteModel {
    func copy() -> NoteModel {
        let note = NoteModel(title: self.title, content: self.content, createdTime: self.updatedDate)
        note.id = self.id
        return note
    }
}
