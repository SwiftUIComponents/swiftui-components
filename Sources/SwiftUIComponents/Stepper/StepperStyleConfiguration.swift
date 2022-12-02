//
//  StepperStyleConfiguration.swift
//  
//
//  Created by taha on 12/1/22.
//

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
