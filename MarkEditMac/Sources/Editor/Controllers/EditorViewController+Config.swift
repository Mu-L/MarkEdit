//
//  EditorViewController+Config.swift
//  MarkEditMac
//
//  Created by cyan on 1/28/23.
//

import AppKit
import AppKitControls
import MarkEditCore
import MarkEditKit

extension EditorViewController {
  func setTheme(_ theme: AppTheme, animated: Bool) {
    guard animated else {
      return setTheme(theme)
    }

    webView.takeSnapshot(with: nil) { image, error in
      guard error == nil, let image else {
        return self.setTheme(theme)
      }

      // Perform a cross-dissolve effect to make theme switching smoother
      let snapshotView = NSImageView(image: image)
      snapshotView.frame = self.webView.bounds
      self.view.addSubview(snapshotView)
      self.setTheme(theme)

      NSAnimationContext.runAnimationGroup { _ in
        snapshotView.animator().alphaValue = 0
      } completionHandler: {
        snapshotView.removeFromSuperview()
      }
    }
  }

  func setTheme(_ theme: AppTheme) {
    updateWindowColors(theme)
    bridge.config.setTheme(name: theme.editorTheme)

    // It's possible to select a light theme for dark mode,
    // override the window appearance to keep consistent.
    let resolvedAppearance = theme.resolvedAppearance
    view.window?.appearance = resolvedAppearance

    // Also update windows that inherit appearance from the editor
    completionContext.appearance = resolvedAppearance
    NSApp.windows.compactMap { $0 as? GotoLineWindow }.forEach {
      $0.appearance = resolvedAppearance
    }
  }

  func setFontFace(_ fontFace: WebFontFace) {
    bridge.config.setFontFace(fontFace: fontFace)
  }

  func setFontSize(_ fontSize: Double) {
    bridge.config.setFontSize(fontSize: fontSize)
  }

  func setShowLineNumbers(enabled: Bool) {
    bridge.config.setShowLineNumbers(enabled: enabled)
  }

  func setShowActiveLineIndicator(enabled: Bool) {
    bridge.config.setShowActiveLineIndicator(enabled: enabled)
  }

  func setInvisiblesBehavior(behavior: EditorInvisiblesBehavior) {
    bridge.config.setInvisiblesBehavior(behavior: behavior)
  }

  func setShowSelectionStatus(enabled: Bool) {
    statusView.isHidden = !enabled
  }

  func setTypewriterMode(enabled: Bool) {
    bridge.config.setTypewriterMode(enabled: enabled)
  }

  func setFocusMode(enabled: Bool) {
    bridge.config.setFocusMode(enabled: enabled)
  }

  func setLineWrapping(enabled: Bool) {
    bridge.config.setLineWrapping(enabled: enabled)
  }

  func setLineHeight(_ lineHeight: Double) {
    bridge.config.setLineHeight(lineHeight: lineHeight)
  }

  func setDefaultLineBreak(_ lineBreak: String?) {
    bridge.config.setDefaultLineBreak(lineBreak: lineBreak)
  }

  func setTabKeyBehavior(_ behavior: TabKeyBehavior) {
    bridge.config.setTabKeyBehavior(behavior: behavior)
  }

  func setIndentUnit(_ unit: IndentUnit) {
    bridge.config.setIndentUnit(unit: unit.characters)
  }

  func setInlinePredictions(enabled: Bool) {
    webView.configuration.allowsInlinePredictions = NSSpellChecker.InlineCompletion.webKitEnabled
  }

  func setSuggestWhileTyping(enabled: Bool) {
    bridge.config.setSuggestWhileTyping(enabled: enabled)
  }
}
