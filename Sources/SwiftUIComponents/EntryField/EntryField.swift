//
//  File.swift
//  
//
//  Created by taha on 12/2/22.
//

import SwiftUI

public struct EntryField<Content: View, Icon: View, Label: View, LeadingAccessoryView: View, TrailingAccessoryView: View>: View {
  
  var content: Content
  var icon: Icon?
  var label: Label //top label
  var leadingAccessoryView: LeadingAccessoryView
  var trailingAccessoryView: TrailingAccessoryView
  var validation: InputValidation
  
  @Binding var isEditing: Bool
  
  @ScaledMetric(relativeTo:.body)
  private var iconSize = 16
  
  @State var gradientAngleOffset: Double = 0
  
  public init(content: Content, icon: Icon? = nil, label: Label, leadingAccessoryView: LeadingAccessoryView, trailingAccessoryView: TrailingAccessoryView, validation: InputValidation, isEditing: Binding<Bool>) {
    self.content = content
    self.icon = icon
    self.label = label
    self.leadingAccessoryView = leadingAccessoryView
    self.trailingAccessoryView = trailingAccessoryView
    self.validation = validation
    self._isEditing = isEditing
  }

  public var body: some View {
    VStack (alignment: .leading, spacing: 4) {
      label
        .padding(.horizontal)
        .font(.caption)
        .foregroundStyle(.secondary)
        .alignmentGuide(.firstTextBaseline) { d in
            .nan
        }
      HStack(alignment: .center, spacing: 8) {
        Spacer(minLength: 8)
        //leadingValidation
          //.padding(.trailing, 3)
        leadingAccessoryView
        content
        //trailingValidation
        trailingAccessoryView
          .frame(minHeight: 54, alignment: .center)
          .padding(.horizontal, 16)
          .contentShape(Rectangle())
          .padding(.leading, -12)
          .padding(.trailing, -16)
        Spacer()
      }
      .frame(minHeight: 54, alignment: .center)
      .background {
        ZStack {
          ContainerRelativeShape()
            .fill(.red)
            .clipShape(Capsule())
          ContainerRelativeShape()
            .inset(by: -4)
            .fill(AngularGradient(colors: [
              .red,
              .orange,
              .green,
              .blue,
              .indigo,
              .red
            ], center: .center, startAngle: .degrees(0 + gradientAngleOffset), endAngle: .degrees(360 + gradientAngleOffset)))
            .cornerRadius(27)
            .animation(.linear(duration: 5).repeatForever(autoreverses: false), value: gradientAngleOffset)
            .blur(radius: isEditing ? 3.0 : 0.5)
            .opacity(isEditing ? 1.0 : 0.1)
            .zIndex(-1)
        }
      }
    }
    .padding()
  }
}
