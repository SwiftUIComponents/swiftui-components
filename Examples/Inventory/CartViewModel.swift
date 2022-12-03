//
//  CartViewModel.swift
//  Inventory
//
//  Created by taha on 12/2/22.
//

import Foundation

class CartViewModel: ObservableObject {
  @Published var items = CartItem.sample
}
