//
//  OnHoldViewModifier.swift
//  
//
//  Created by taha on 12/1/22.
//

import SwiftUI

struct OnHold: ViewModifier {
  var perform: () -> Void

  @State private var isPressed = false

  func hold() async throws {
    perform()
    try await Task.sleep(for: .seconds(0.5))
    while true {
      perform()
      try await Task.sleep(for: .seconds(0.1))
    }
  }

  func body(content: Content) -> some View {
    content
      .gesture(
        DragGesture(minimumDistance: 0)
            .onChanged { _ in
              isPressed = true
            }
            .onEnded { _ in
              isPressed = false
            }
      )
      .task(id: isPressed) {
        guard isPressed else { return }
        try? await hold()
      }
  }
}

extension View {
  func onHold(_ perform: @escaping () -> Void) -> some View {
    modifier(OnHold(perform: perform))
  }
}
