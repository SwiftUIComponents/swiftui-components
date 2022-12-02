//
//  StepperStyle.swift
//  
//
//  Created by taha on 12/1/22.
//

import SwiftUI

public protocol StepperStyle<Body> {
  associatedtype Body: View
  func makeBody(_ configuration: StepperStyleConfiguration) -> Body
}
