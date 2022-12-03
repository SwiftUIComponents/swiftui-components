import SwiftUI

@main
struct InventoryApp: App {
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        NavigationLink("Stepper") {
          CartView(cartViewModel: CartViewModel())
        }
        .padding()
        NavigationLink("AddressForm") {
          AddressView()
        }
        .padding()
      }
    }
  }
}
