//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class FieldAxiomTests: XCTestCase {
    // We test the distributivity of product over the addition, since the remaining field axioms
    // are tested in 'AbelianAdditiveGroupAxiomsTests' and 'AbelianMultiplicativeGroupAxiomTests'.

    func testLeftDistributivityOfProductOverAddition() throws {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()

        let distributivityFactoredExpression = try MathExpression(String(format: Formula.FieldAxiomTests.leftDistributivityFactored, a, b, c))
        let distributivityExpandedExpression = try MathExpression(String(format: Formula.FieldAxiomTests.distributivityExpanded, a, b, a, c))
        let expectedResult = Double(a) * Double(b) + Double(a) * Double(c)

        XCTAssertEqual(distributivityFactoredExpression.evaluate(), distributivityExpandedExpression.evaluate())
        XCTAssertEqual(distributivityFactoredExpression.evaluate(), expectedResult)
    }

    func testRightDistributivityOfProductOverAddition() throws {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()

        let distributivityFactoredExpression = try MathExpression(String(format: Formula.FieldAxiomTests.rightDistributivityFactored, a, b, c))
        let distributivityExpandedExpression = try MathExpression(String(format: Formula.FieldAxiomTests.distributivityExpanded, a, c, b, c))
        let expectedResult = Double(a) * Double(c) + Double(b) * Double(c)

        XCTAssertEqual(distributivityFactoredExpression.evaluate(), distributivityExpandedExpression.evaluate())
        XCTAssertEqual(distributivityFactoredExpression.evaluate(), expectedResult)
    }
}
