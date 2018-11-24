//
//  NoteManager.swift
//  TablePlus-iOS
//
//  Created by Son on 11/24/18.
//  Copyright © 2018 TablePlus. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftDate

class NoteManager: RealmManager {
    func loadNotes(_ completion: @escaping ([NoteModel]) -> Void) throws {
        let notes = objects(with: NoteModel.self, sortKeypath: "updatedDate", ascending: false)
        if notes.isEmpty {
            let samples = createSampleNotes()
            try save(notes: samples)
            completion(samples)
        } else {
            completion(notes)
        }
    }

    func update(note: NoteModel) throws {
        try save(note: note)
    }

    func save(note: NoteModel) throws {
        try realm?.write {
            realm?.add(note, update: true)
            NotificationCenter.default.post(name: NoteModel.noteDidChangedNotification, object: nil)
        }
    }

    func save(notes: [NoteModel]) throws {
        try realm?.write {
            realm?.add(notes, update: true)
            NotificationCenter.default.post(name: NoteModel.noteDidChangedNotification, object: nil)
        }
    }

    private var dummyTxt = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

    private func createSampleNotes() -> [NoteModel] {
        return [
            NoteModel(title: "Note 1", content: dummyTxt, createdTime: Date() - 30.days),
            NoteModel(title: "Note 2", content: dummyTxt, createdTime: Date() - 30.days),
            NoteModel(title: "Note 3", content: dummyTxt, createdTime: Date() - 30.days),
            NoteModel(title: "Note 4", content: dummyTxt, createdTime: Date() - 30.days),
            NoteModel(title: "Note 5", content: dummyTxt, createdTime: Date() - 60.days),
            NoteModel(title: "Note 6", content: dummyTxt, createdTime: Date() - 60.days),
            NoteModel(title: "Note 7", content: dummyTxt, createdTime: Date() - 60.days),
            NoteModel(title: "Note 8", content: dummyTxt, createdTime: Date() - 90.days),
            NoteModel(title: "Note 9", content: dummyTxt, createdTime: Date() - 90.days),
            NoteModel(title: "Note 10", content: dummyTxt, createdTime: Date() - 90.days),
            NoteModel(title: "Note 11", content: dummyTxt, createdTime: Date() - 120.days),
        ]
    }
}
