//
//  ContentView.swift
//
//
//  Created by Taha Bebek on 11/29/22.
//

import Foundation
import SwiftUI
import SwiftUIComponents

public struct ContentView: View {
  @State var items = CartItem.sample

  var shipping: Decimal = 5

  var total: Decimal {
    items.map { $0.price * Decimal($0.quantity) }.reduce(0, +) + shipping
  }

  public var body: some View {
    List($items) { $item in
      HStack {
        Image("coffee-bag")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 60, height: 60)
          .background(Color(white: 0.9))
        VStack {
          HStack {
            Text(item.name)
            Spacer()
            Text(item.price.formatted(.currency(code: "EUR")))
          }
          Stepper(value: $item.quantity, range: 0...99) {
            Text("Quantity")
          }
          .stepperStyle(.capsule)
            .controlSize(.small)
        }
      }
    }
    .safeAreaInset(edge: .bottom, spacing: 0, content: {
      VStack {
        HStack {
          Text("Shipping")
          Spacer()
          Text(shipping.formatted(.currency(code: "EUR")))
        }
        HStack {
          Text("Total")
          Spacer()
          Text(total.formatted(.currency(code: "EUR")))
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

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ContentView()
    }
  }
}

struct CartItem: Identifiable {
  var id: Int

  var name: String

  var bagColor: Color

  var price: Decimal

  var quantity: Int

  var total: Decimal {
    price * Decimal(quantity)
  }

  static var sample: [CartItem] {
    [
      CartItem(id: 1,
               name: "Ethiopia Hello Verity",
               bagColor: Color(red: 1.0, green: 0.7, blue: 0.0),
               price: 12.45,
               quantity: 1),
      CartItem(id: 2,
               name: "Seasonal Blend, Spring Here",
               bagColor: Color(red: 0.0, green: 0.8, blue: 0.4),
               price: 9.99,
               quantity: 2),
      CartItem(id: 3,
               name: "Indonesian Frinza Collective",
               bagColor: Color(red: 0.9, green: 0.3, blue: 0.0),
               price: 8.29,
               quantity: 1),
      CartItem(id: 4,
               name: "House Blend Dark",
               bagColor: Color(red: 0.0, green: 0.1, blue: 0.4),
               price: 9.95,
               quantity: 1)
    ]
  }
}
