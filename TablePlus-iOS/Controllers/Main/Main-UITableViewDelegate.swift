//
//  Main-UITableViewDelegate.swift
//  TablePlus-iOS
//
//  Created by Son on 11/24/18.
//  Copyright © 2018 TablePlus. All rights reserved.
//

import UIKit

extension MainViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "NoteDetailViewController" else { return }
        guard let note = sender as? NoteModel else { return }
        (segue.destination as? NoteDetailViewController)?.note = note.copy()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let note = getNote(for: indexPath) else { return }
        performSegue(withIdentifier: "NoteDetailViewController", sender: (note))
    }
}
