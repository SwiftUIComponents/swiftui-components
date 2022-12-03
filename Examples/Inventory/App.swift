import SwiftUI

@main
struct InventoryApp: App {
  var body: some Scene {
    WindowGroup {
      CartView(cartViewModel: CartViewModel())
    }
  }
}
