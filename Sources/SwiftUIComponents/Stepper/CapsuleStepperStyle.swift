//
//  File.swift
//  
//
//  Created by taha on 12/1/22.
//

import SwiftUI

public extension StepperStyle where Self == CapsuleStepperStyle {
  static var capsule: CapsuleStepperStyle { return .init() }
}

public struct CapsuleStepperStyle: StepperStyle {
  public init() {}
  public func makeBody(_ configuration: StepperStyleConfiguration) -> some View {
    CapsuleStepper(configuration: configuration)
  }
}
