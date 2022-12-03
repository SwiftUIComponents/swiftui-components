//
//  AddressForm.swift
//  Inventory
//
//  Created by taha on 12/2/22.
//

import SwiftUI
import SwiftUIComponents

struct AddressView: View {
  @State var emailString = ""
  @State var isEditing = false

  let placeholder = "Email Adress"
  let icon = Image(systemName: "home")
  let leadingAccessoryView = Image(systemName: "envelope")
  let trailingAccessoryView = Image(systemName: "info.circle")
  let label = Text("Label")
  let validation = InputValidation()
    
  var body: some View {
    EntryField(
      content: TextField("Email Address", text: $emailString),
      icon: icon,
      label: label,
      leadingAccessoryView: leadingAccessoryView,
      trailingAccessoryView: trailingAccessoryView,
      validation: validation,
      isEditing: $isEditing)
  }
}

struct AddressView_Previews: PreviewProvider {
  static var previews: some View {
    AddressView()
  }
}
