//
//  CapsuleStepper.swift
//  
//
//  Created by taha on 12/1/22.
//

import SwiftUI

struct CapsuleStepper: View {
  var configuration: StepperStyleConfiguration

  @Environment(\.controlSize) var controlSize

  var padding: Double {
    switch controlSize {
    case .mini: return 4
    case .small: return 6
    case .regular: return 8
    case .large: return 10
    @unknown default:
      return 8
    }
  }

  var body: some View {
    HStack(alignment: .center) {
      configuration.label
      Spacer()
      HStack {
        Button { configuration.value.wrappedValue -= 1 } label: { Text("-") }
        Text(configuration.value.wrappedValue.formatted())
        Button { configuration.value.wrappedValue += 1 } label: { Text("+") }
      }
      .transformEnvironment(\.font, transform: { font in
        if font != nil { return }
        switch controlSize {
        case .mini: font = .footnote
        case .small: font = .callout
        default: font = .body
        }
      })
      .padding(.vertical, padding)
      .padding(.horizontal, padding * 2)
      .foregroundColor(.white)
      .background {
        Capsule()
          .fill(.tint)
      }
    }
    .buttonStyle(.plain)
  }
}

public struct CapsuleStepperStyle: StepperStyle {
  public init() {}
  public func makeBody(_ configuration: StepperStyleConfiguration) -> some View {
    CapsuleStepper(configuration: configuration)
  }
}

public extension StepperStyle where Self == CapsuleStepperStyle {
  static var capsule: CapsuleStepperStyle { return .init() }
}
