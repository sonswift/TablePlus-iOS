//
//  MainViewController.swift
//  TablePlus-iOS
//
//  Created by Son on 11/24/18.
//  Copyright © 2018 TablePlus. All rights reserved.
//

import UIKit
import SwiftDate

class MainViewController: UITableViewController {

    let manager = NoteManager(inMemory: false)
    var sections = [NoteSectionModel]()

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        customInitLayout()
        loadSections()
        addObservers()
    }

    private func customInitLayout() {
        title = "Your Notes"
    }

    private func loadSections() {
        do {
            try manager.loadNotes { [weak self] (notes) in
                guard let `self` = self else { return }
                let grouppedNotes = self.group(notes: notes)
                self.sections.append(contentsOf: grouppedNotes)
                self.tableView.reloadData()
            }
        } catch { print(error._code, error.localizedDescription) }
    }
    // Grouped by Month
    private func group(notes: [NoteModel]) -> [NoteSectionModel] {
        var dateList = [String]()
        var sections = [NoteSectionModel]()
        for note in notes {
            let monthYearStr = note.updatedDate.toString(DateToStringStyles.custom("MMMM YYYY"))
            if dateList.contains(monthYearStr) {
                for section in sections where section.date == note.updatedDate.dateAtStartOf(Calendar.Component.month) {
                    section.notes.append(note)
                    break
                }
            } else {
                dateList.append(monthYearStr)

                let section = NoteSectionModel(date: note.updatedDate.dateAtStartOf(Calendar.Component.month))
                section.notes.append(note)
                sections.append(section)
            }
        }
        return sections
    }

    // MARK: - IBActions
    @IBAction func addButtonTouch(_ sender: Any) {
        performSegue(withIdentifier: "NoteDetailViewController", sender: (NoteModel()))
    }
}

// MARK: - Observations
extension MainViewController {
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(onNoteModelDidChanged(_:)),
                                               name: NoteModel.noteDidChangedNotification, object: nil)
    }

    @objc func onNoteModelDidChanged(_ notification: Notification) {
        loadSections()
    }
}
