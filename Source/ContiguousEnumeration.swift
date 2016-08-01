// Copyright © 2016 Gavan Chan. All rights reserved.

// MARK: Protocol - Contiguous Enumeration

/// A contiguous sequence of enumerable data.
///
/// Conforming types provide a "base" value from which subsequent values can
/// be derived, subject to striding semantics which are also defined by the
/// implementing type.
public protocol ContiguousEnumeration: Strideable {

  /// The "base" value of this enumeration.
  static var base: Self { get }

  /// The value of this enumeration which is `n` subsequent strides from `self`.
  ///
  /// - note: This function is used to satisfy non-optional `advancedBy(n:)`
  ///     defined in the `Strideable` protocol. Calling the default
  ///     implementation of `advancedBy(n:)` is potentially unsafe, as striding
  ///     past the bounds of conforming types will emit an error.
  ///
  /// - parameters:
  ///   - n: The number of `Stride`s to take from `self`.
  ///
  /// - returns: The value of this enumeration which is `n` strides from `self`.
  func advancedBy(n: Self.Stride) -> Self?

}

// MARK:
// MARK: Extension - Contiguous Enumeration + Convenience

// Functionality that is made available on conforming types.

public extension ContiguousEnumeration {

  /// An array whose content captures all possible values for the
  /// contiguous enumeration.
  static var cases: Array<Self> {
    var current: Self       = Self.base
    var cases: Array<Self>  = [current]

    while let value = current.advancedBy(1) {
      cases.append(value)
      current = value
    }

    return cases
  }

  /// The number of case values on this type.
  static var count: Int {
    return cases.count
  }
  
}

// MARK:
// MARK: Extension - Contiguous Enumeration + Strideable

// Functions defined in the `Strideable` protocol.

public extension ContiguousEnumeration {

  func advancedBy(n: Self.Stride) -> Self {
    guard let value = advancedBy(n) else { fatalError("Attempted to advance past enumeration bounds.") }
    return value
  }
  
}

// MARK:
// MARK: Extension - Contiguous Enumeration + Raw Representable - Integer

// Default implementation for values backed by raw types.

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

import Foundation
