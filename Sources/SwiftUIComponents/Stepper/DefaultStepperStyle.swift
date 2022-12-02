//
//  DefaultStepperStyle.swift
//  
//
//  Created by taha on 12/1/22.
//

import SwiftUI

public extension StepperStyle where Self == DefaultStepperStyle {
  static var `default`: DefaultStepperStyle { return .init() }
}

public struct DefaultStepperStyle: StepperStyle {
  public init() {}
  public func makeBody(_ configuration: StepperStyleConfiguration) -> some View {
    SwiftUI.Stepper(value: configuration.value, in: configuration.range) {
      configuration.label
    }
  }
}
