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
    await callPerform()
    try await Task.sleep(for: .seconds(0.5))
    while true {
      await callPerform()
      try await Task.sleep(for: .seconds(0.1))
    }
  }
  
  @MainActor
  func callPerform() {
    perform()
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
