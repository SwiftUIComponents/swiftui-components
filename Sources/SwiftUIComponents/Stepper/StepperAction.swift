//
//  File.swift
//  
//
//  Created by taha on 12/2/22.
//

import Foundation

func increment(_ value: inout Int, range: ClosedRange<Int>) {
  if value < range.upperBound { value += 1 }
}

func decrement(_ value: inout Int, range: ClosedRange<Int>) {
  if value > range.lowerBound { value -= 1 }
}
