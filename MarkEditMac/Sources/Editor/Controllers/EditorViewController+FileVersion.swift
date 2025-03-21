//
//  EditorViewController+FileVersion.swift
//  MarkEdit
//
//  Created by cyan on 11/10/24.
//

import AppKit
import MarkEditKit

extension EditorViewController {
  func deleteFileVersions(_ versions: [NSFileVersion]) {
    let alert = NSAlert()
    alert.alertStyle = .warning

    guard !versions.isEmpty else {
      alert.messageText = Localized.FileVersion.noVersionsTitle
      alert.runModal()
      return
    }

    alert.messageText = String(format: Localized.FileVersion.foundVersionsFormat, versions.count)
    alert.informativeText = Localized.FileVersion.cannotBeUndone

    alert.addButton(withTitle: Localized.General.delete)
    alert.addButton(withTitle: Localized.General.cancel)

    guard alert.runModal() == .alertFirstButtonReturn else {
      return
    }

    DispatchQueue.global(qos: .background).async {
      do {
        try versions.forEach { try $0.remove() }
      } catch {
        Logger.log(.error, error.localizedDescription)
      }
    }
  }
}
