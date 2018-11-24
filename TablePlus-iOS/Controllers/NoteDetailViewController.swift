//
//  NoteDetailViewController.swift
//  TablePlus-iOS
//
//  Created by Son on 11/24/18.
//  Copyright © 2018 TablePlus. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {

    @IBOutlet weak var constraintBottomTextView: NSLayoutConstraint!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    let manager = NoteManager(inMemory: false)
    var note: NoteModel!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        customInitLayout()
        addObservers()
    }

    private func customInitLayout() {
        titleTextField.text = note.title
        textView.text = note.content
    }

    @IBAction func saveButtonTouch(_ sender: Any) {
        note.title = titleTextField.text ?? ""
        note.content = textView.text ?? ""
        save(note: note)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Observations
extension NoteDetailViewController {
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillChangeFrame(_:)),
                                               name: UIApplication.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc func onKeyboardWillChangeFrame(_ notification: Notification) {
        guard let userInfo = (notification as NSNotification).userInfo else { return }
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        guard let keyboardFrame = endFrame else { return }
        constraintBottomTextView.constant = UIScreen.main.bounds.height-keyboardFrame.minY
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}

// MARK: - Data Updated & Saved
extension NoteDetailViewController {
    func save(note: NoteModel) {
        do {
            try manager.save(note: note)
        } catch {
            print("Note Saved Error: \(error._code, error.localizedDescription)")
        }
    }
}
