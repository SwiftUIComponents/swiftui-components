//
//  Stepper.swift
//  
//
//  Created by Taha Bebek on 11/29/22.
//

import Foundation
import SwiftUI

public struct StepperStyleConfiguration {
  var value: Binding<Int>
  var label: Label
  var range: ClosedRange<Int>

  struct Label: View {
    var underlyingLabel: AnyView

    var body: some View {
      underlyingLabel
    }
  }
}

public protocol StepperStyle<Body> {
  associatedtype Body: View
  func makeBody(_ configuration: StepperStyleConfiguration) -> Body
}

public struct DefaultStepperStyle: StepperStyle {
  public init() {}
  public func makeBody(_ configuration: StepperStyleConfiguration) -> some View {
    SwiftUI.Stepper(value: configuration.value, in: configuration.range) {
      configuration.label
    }
  }
}

public extension StepperStyle where Self == DefaultStepperStyle {
  static var defaultStyle: DefaultStepperStyle { return .init() }
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
  }
}

struct StepperStyleKey: EnvironmentKey {
  static let defaultValue: any StepperStyle = DefaultStepperStyle()
}

extension EnvironmentValues {
  var stepperStyle: any StepperStyle {
    get { self[StepperStyleKey.self] }
    set { self[StepperStyleKey.self] = newValue }
  }
}

public extension View {
  func stepperStyle(_ style: some StepperStyle) -> some View {
    environment(\.stepperStyle, style)
  }
}

struct Stepper_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Stepper(value: .constant(5), range: 0...100) {
        Text("Default style")
      }
      .stepperStyle(.defaultStyle)
      .controlSize(.mini)

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
    }
    .padding()
  }
}
