//
//  File.swift
//  
//
//  Created by taha on 12/1/22.
//

import SwiftUI

struct VerticalStepper: View {
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
        ZStack {
          Text(configuration.range.upperBound.formatted())
            .monospacedDigit()
            .hidden()
          Text(configuration.value.wrappedValue.formatted())
            .monospacedDigit()
        }
        VStack(spacing: 4) {
          Image(systemName: "chevron.up")
          Image(systemName: "chevron.down")
        }
      }
      .padding(.vertical, padding)
      .padding(.horizontal, padding * 2)
      .background {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
          .fill(.regularMaterial)
      }
      .overlay {
        VStack(spacing: 0) {
          Rectangle()
            .fill(.clear)
            .contentShape(Rectangle())
            .onHold {
              increment(&configuration.value.wrappedValue, range: configuration.range)
            }
          Rectangle()
            .fill(.clear)
            .contentShape(Rectangle())
            .onHold {
              decrement(&configuration.value.wrappedValue, range: configuration.range)
            }
        }
      }
    } label: {
      configuration.label
    }
    .buttonStyle(.plain)
  }
}

struct VerticalStepper_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 16) {
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
    .stepperStyle(.vertical)
    .padding()
  }
}
