// Copyright © 2016 Gavan Chan. All rights reserved.

public protocol ContiguousEnumeration: Strideable {

  static var base: Self { get }

  func advancedBy(n: Self.Stride) -> Self?

}

public extension ContiguousEnumeration where
  Self: RawRepresentable,
  Self.RawValue == Stride,
  Self.RawValue.Distance == Self.RawValue,
  Self.RawValue: IntegerType
{

  func advancedBy(n: Self.Stride) -> Self? {
    return Self(rawValue: rawValue + n)
  }

  func distanceTo(other: Self) -> Self.Stride {
    return rawValue.distanceTo(other.rawValue)
  }

}

public extension ContiguousEnumeration {

  func advancedBy(n: Self.Stride) -> Self {
    guard let value = advancedBy(n) else { fatalError("Attempted to advance past enumeration bounds.") }
    return value
  }

  static var cases: Array<Self> {
    var current: Self       = Self.base
    var cases: Array<Self>  = [current]

    while let value = current.advancedBy(1) {
      cases.append(value)
      current = value
    }

    return cases
  }

  static var count: Int {
    return cases.count
  }

}

import Foundation
