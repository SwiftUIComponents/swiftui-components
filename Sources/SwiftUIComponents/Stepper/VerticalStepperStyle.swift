//
//  VerticalStepperStyle.swift
//  
//
//  Created by taha on 12/1/22.
//

import SwiftUI

public extension StepperStyle where Self == VerticalStepperStyle {
  static var vertical: VerticalStepperStyle { return .init() }
}

public struct VerticalStepperStyle: StepperStyle {
  public init() {}
  public func makeBody(_ configuration: StepperStyleConfiguration) -> some View {
    VerticalStepper(configuration: configuration)
  }
}
