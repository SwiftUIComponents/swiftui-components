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
    LabeledContent {
      HStack {
        Text("-")
          .accessibilityLabel("Decrement")
          .onHold {
            decrement(&configuration.value.wrappedValue, range: configuration.range)
          }
        ZStack {
          Text(configuration.range.upperBound.formatted())
            .monospacedDigit()
            .hidden()
          Text(configuration.value.wrappedValue.formatted())
            .monospacedDigit()
        }
        Text("+")
          .accessibilityLabel("Increment")
          .onHold {
            increment(&configuration.value.wrappedValue, range: configuration.range)
          }
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
    } label: {
      configuration.label
    }
    .buttonStyle(.plain)
  }
}

struct CapsuleStepper_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Stepper(value: .constant(5), range: 0...100) {
        Text("Mini")
      }
      .controlSize(.mini)

      Stepper(value: .constant(5), range: 0...100) {
        Text("Small")
      }
      .controlSize(.small)

      Stepper(value: .constant(5), range: 0...100) {
        Text("Regular")
      }
      .controlSize(.regular)

      Stepper(value: .constant(5), range: 0...100) {
        Text("Large")
      }
      .controlSize(.large)

      Stepper(value: .constant(5), range: 0...100) {
        Text("Default")
      }

      Stepper(value: .constant(5), range: 0...100) {
        Text("Large")
      }
      .controlSize(.large)
      .font(.largeTitle)
    }
    .stepperStyle(.capsule)
    .padding()
  }
}
