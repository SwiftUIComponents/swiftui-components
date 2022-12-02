//
//  StepperStyleEnvironmentValue.swift
//  
//
//  Created by taha on 12/1/22.
//

import SwiftUI

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
