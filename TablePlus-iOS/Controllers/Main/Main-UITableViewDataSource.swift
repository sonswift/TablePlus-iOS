//
//  Main-UITableViewDataSource.swift
//  TablePlus-iOS
//
//  Created by Son on 11/24/18.
//  Copyright © 2018 TablePlus. All rights reserved.
//

import UIKit
import SwiftDate

extension MainViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard sections.count > section else { return 0 }
        return sections[section].notes.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let _cell = cell as? NoteTableViewCell else { return }
        guard let note = getNote(for: indexPath) else { return }
        _cell.titleLabel.text = note.title
        _cell.contentLabel.text = note.content
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = NoteHeaderView()
        if sections.count > section {
            header.titleLabel.text = sections[section].date.toString(DateToStringStyles.custom("MMMM YYYY")).uppercased()
        }
        return header
    }

    func getNote(for indexPath: IndexPath) -> NoteModel? {
        guard sections.count > indexPath.section else { return nil }
        let section = sections[indexPath.section]
        guard section.notes.count > indexPath.row else { return nil }
        return section.notes[indexPath.row]
    }
}
