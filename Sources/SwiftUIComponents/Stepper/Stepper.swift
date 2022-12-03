//
//  Stepper.swift
//  
//
//  Created by taha on 11/29/22.
//

import SwiftUI

public struct Stepper<Label: View>: View {
  @Binding var value: Int
  @Environment(\.stepperStyle) var style

  var range: ClosedRange<Int>
  @ViewBuilder var label: Label

  public init(value: Binding<Int>, range: ClosedRange<Int>, label: () -> Label) {
    self._value = value
    self.range = range
    self.label = label()
  }

  public var body: some View {
    AnyView(style.makeBody(.init(value: $value, label: .init(underlyingLabel: AnyView(label)), range: range)))
      .accessibilityElement(children: .ignore)
      .accessibilityRepresentation {
        label
      }
      .accessibilityValue(value.formatted())
      .accessibilityAdjustableAction { direction in
        switch direction {
        case .increment:
          increment(&value, range: range)
        case .decrement:
          decrement(&value, range: range)
        @unknown default:
          break
        }
      }
  }
}

struct Stepper_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Stepper(value: .constant(5), range: 0...100) {
        Text("Default style")
      }
      .stepperStyle(.default)

      Stepper(value: .constant(5), range: 0...100) {
        Text("Capsule")
      }
      .stepperStyle(.capsule)

      Stepper(value: .constant(5), range: 0...100) {
        Text("Vertical")
      }
      .stepperStyle(.vertical)
    }
    .controlSize(.regular)
    .padding()
  }
}
