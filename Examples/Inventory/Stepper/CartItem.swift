//
//  CartItem.swift
//  Inventory
//
//  Created by taha on 12/2/22.
//

import Foundation

struct CartItem: Identifiable {
  var id: Int
  var name: String
  var price: Decimal
  var quantity: Int

  var total: Decimal {
    price * Decimal(quantity)
  }

  static var sample: [CartItem] {
    [
      CartItem(id: 1,
               name: "Star Wars The Mandalorian T-Shirt",
               price: 22.99,
               quantity: 1),
      CartItem(id: 2,
               name: "Unstable Unicorns Card Game",
               price: 14.42,
               quantity: 2),
      CartItem(id: 3,
               name: "Squishmallows 12-Inch Yellow Meringue Macaron Plush",
               price: 15.99,
               quantity: 1),
    ]
  }
}
