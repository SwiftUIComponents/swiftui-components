//
//  ContentView.swift
//
//
//  Created by Taha Bebek on 11/29/22.
//

import Foundation
import SwiftUI
import SwiftUIComponents

public struct CartView: View {
  
  @ObservedObject var cartViewModel: CartViewModel
  
  var total: Decimal {
    cartViewModel.items.map { $0.price * Decimal($0.quantity) }.reduce(0, +)
  }

  public var body: some View {
    List($cartViewModel.items) { $item in
      HStack {
        VStack {
          HStack {
            Text(item.name)
            Spacer()
            Text(item.price.formatted(.currency(code: "USD")))
          }
          Stepper(value: $item.quantity, range: 0...10) {
            Text("Quantity")
          }
          .stepperStyle(.vertical)
          .controlSize(.small)
        }
      }
      .accessibilityElement(children: .combine)
    }
    .safeAreaInset(edge: .bottom, spacing: 0, content: {
      VStack {
        HStack {
          Text("Total")
          Spacer()
          Text(total.formatted(.currency(code: "USD")))
        }
        Button("Checkout") { }
          .buttonStyle(FullWidthButtonStyle())
      }
      .padding()
      .background(.regularMaterial)
    })
    .listStyle(.plain)
    .navigationTitle("Cart")
  }
}

struct FullWidthButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(maxWidth: .infinity)
      .foregroundColor(.white)
      .padding()
      .background {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
          .fill(.tint)
      }
  }
}

struct CartView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      CartView(cartViewModel: CartViewModel())
    }
  }
}
