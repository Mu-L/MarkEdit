//
//  TextCompletionPanel.swift
//
//  Created by cyan on 3/2/23.
//

import AppKit
import SwiftUI

@MainActor
final class TextCompletionPanel: NSPanel, TextCompletionPanelProtocol {
  private var state = TextCompletionState()
  private var mainView: NSHostingView<TextCompletionView>?

  init(
    modernStyle: Bool,
    effectViewType: NSView.Type,
    localizable: TextCompletionLocalizable,
    commitCompletion: @escaping () -> Void
  ) {
    super.init(
      contentRect: .zero,
      styleMask: .borderless,
      backing: .buffered,
      defer: false
    )

    let mainView = NSHostingView(rootView: TextCompletionView(
      modernStyle: modernStyle,
      state: state,
      localizable: localizable,
      commitCompletion: commitCompletion
    ))

    let contentView = ContentView(modernStyle: modernStyle, effectViewType: effectViewType, frame: .zero)
    contentView.addSubview(mainView)

    self.mainView = mainView
    self.contentView = contentView
    self.isOpaque = false
    self.hasShadow = true
    self.backgroundColor = .clear
  }

  override var canBecomeKey: Bool {
    // We don't need the completion panel to be the key window,
    // keyboard events are handled in the editor and redirected.
    false
  }

  override func layoutIfNeeded() {
    super.layoutIfNeeded()

    if let mainView, let contentView {
      mainView.frame = contentView.bounds
    }
  }

  func updateCompletions(_ completions: [String], query: String) {
    state.items = completions
    state.query = query

    // Getting a measured view size to better determine the panel width
    if let measuredSize = mainView?.rootView.measuredSize {
      let preferredRect = CGRect(
        origin: frame.origin,
        size: CGSize(width: measuredSize.width, height: frame.height)
      )

      setFrame(preferredRect, display: false)
    }
  }

  func selectedCompletion() -> String {
    state.items[state.selectedIndex]
  }

  func selectPrevious() {
    state.selectedIndex = max(0, state.selectedIndex - 1)
  }

  func selectNext() {
    state.selectedIndex = min(state.items.count - 1, state.selectedIndex + 1)
  }

  func selectTop() {
    state.selectedIndex = 0
  }

  func selectBottom() {
    state.selectedIndex = state.items.count - 1
  }
}

// MARK: - Private

private final class ContentView: NSView {
  init(modernStyle: Bool, effectViewType: NSView.Type, frame: CGRect) {
    super.init(frame: frame)
    wantsLayer = true
    layer?.cornerCurve = .continuous
    layer?.cornerRadius = modernStyle ? 8 : 5

    let effectView = effectViewType.init()
    effectView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(effectView)

    if let blurView = effectView as? NSVisualEffectView {
      blurView.material = .popover
      blurView.state = .active // Looks less dimmed in non-key windows
    }

    NSLayoutConstraint.activate([
      effectView.leadingAnchor.constraint(equalTo: leadingAnchor),
      effectView.trailingAnchor.constraint(equalTo: trailingAnchor),
      effectView.topAnchor.constraint(equalTo: topAnchor),
      effectView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
