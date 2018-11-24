//
//  Notifications.swift
//  TablePlus-iOS
//
//  Created by Son on 11/24/18.
//  Copyright © 2018 TablePlus. All rights reserved.
//

import UIKit

extension NoteModel {
    static var noteDidChangedNotification: Notification.Name {
        return Notification.Name("NoteModel-noteDidChangedNotification")
    }
}
