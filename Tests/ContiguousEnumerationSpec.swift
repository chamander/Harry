// Copyright © 2016 Gavan Chan. All rights reserved.

final class ContiguousEnumerationSpec: QuickSpec {

  enum RollCall: Int, ContiguousEnumeration {
    typealias Stride = Int

    case Brian = 0
    case Nur
    case Gavan
    case Daniel

    static let base: RollCall = Brian

    static let staticCases: Array<RollCall> = [
      .Brian,
      .Nur,
      .Gavan,
      .Daniel,
    ]
  }

  override func spec() {

    describe("A Contiguous Enumeration") {

      it("is able to provide a sequence of all of its unique cases") {

        let expected: Array<RollCall> = RollCall.staticCases

        let actual: Array<RollCall> = RollCall.cases

        expect(actual).to(equal(expected))

      }

      it("is able to provide a count of its unique cases") {

        let expected: Int = RollCall.staticCases.count

        let actual: Int = RollCall.count

        expect(actual).to(equal(expected))

      }

      context("that is backed by an integer type") {

        it("can provide an enum value that is `x` strides away from its raw value") {

          let firstTest: RollCall   = .Nur
          let secondTest: RollCall  = .Gavan

          let firstActual: RollCall?  = RollCall.base.advancedBy(1)
          let secondActual: RollCall? = RollCall.base.advancedBy(2)

          expect(firstActual).to(equal(firstTest))
          expect(secondActual).to(equal(secondTest))

        }

        it("will provide `nil` when asked to provide an enum value with a stride that would stride outside its bounds") {

          let nilTest: RollCall? = RollCall.base.advancedBy(10)

          expect(nilTest).to(beNil())

        }

      }

    }

  }

}

import Quick
import Nimble
@testable import Harry
