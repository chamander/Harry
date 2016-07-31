// Copyright © 2016 Gavan Chan. All rights reserved.

protocol ContiguousEnumeration: Strideable {

  static var base: Self { get }

  func advancedBy(n: Self.Stride) -> Self?

}

extension ContiguousEnumeration where Self: RawRepresentable, Self.RawValue == Stride, Self.RawValue: SignedIntegerType {

  func advancedBy(n: Self.Stride) -> Self? {
    return Self(rawValue: self.rawValue + n)
  }

}

extension ContiguousEnumeration {

  var cases: Array<Self> {
    var current: Self       = Self.base
    var cases: Array<Self>  = [current]

    while let value = current.advancedBy(1) {
      cases.append(value)
      current = value
    }

    return cases
  }

}

import Foundation
