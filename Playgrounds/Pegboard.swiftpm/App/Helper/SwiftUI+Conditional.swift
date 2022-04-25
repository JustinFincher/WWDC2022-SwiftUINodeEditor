//
//  SwiftUI+Conditional.swift
//  ScriptNode
//
//  Created by fincher on 4/21/22.
//

import Foundation
import SwiftUI

extension View {

  @ViewBuilder func conditionalModifier<Content: View>(_ condition: Bool,
                                                       transform: (Self) -> Content) -> some View {
    if condition {
      transform(self)
    } else {
      self
    }
  }
}
