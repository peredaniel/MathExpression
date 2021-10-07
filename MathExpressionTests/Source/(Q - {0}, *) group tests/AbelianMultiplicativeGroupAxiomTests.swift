//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class AbelianMultiplicativeGroupAxiomTests: XCTestCase {
    func testNeutralElement() throws {
        let a = Int16.random()
        let neutralElement: Int16 = 1

        let leftNeutralExpression = try MathExpression(String(format: Formula.AbelianMultiplicativeGroupAxiomTests.neutralElement, neutralElement, a))
        let rightNeutralExpression = try MathExpression(String(format: Formula.AbelianMultiplicativeGroupAxiomTests.neutralElement, a, neutralElement))
        let expectedResult = Double(a)

        XCTAssertEqual(leftNeutralExpression.evaluate(), rightNeutralExpression.evaluate())
        XCTAssertEqual(leftNeutralExpression.evaluate(), expectedResult)
    }

    func testInverse() throws {
        let a = Int16.random()

        let inverseExpression = try MathExpression(String(format: Formula.AbelianMultiplicativeGroupAxiomTests.inverseElement, a))
        let leftProductWithInverse = try MathExpression(String(format: Formula.AbelianMultiplicativeGroupAxiomTests.leftInverse, a, a))
        let rightProductWithInverse = try MathExpression(String(format: Formula.AbelianMultiplicativeGroupAxiomTests.rightInverse, a, a))
        let expectedResult = 1.0 / Double(a)

        XCTAssertEqual(inverseExpression.evaluate(), expectedResult)
        XCTAssertEqual(leftProductWithInverse.evaluate(), rightProductWithInverse.evaluate())
        // We need to round the evaluation result to catch cases in which the result is off 1 by 10^(-6) or less,
        // such as 0.99999999999953 or 1.0000000000005138
        // These errors are acceptable minor errors inherent to floating value computations and not the
        // algorithm itself.
        XCTAssertEqual(leftProductWithInverse.evaluate().rounded(.toNearestOrAwayFromZero), 1.0)
    }

    func testAssociativity() throws {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()

        let leftAssociativityExpression = try MathExpression(String(format: Formula.AbelianMultiplicativeGroupAxiomTests.leftAssociativity, a, b, c))
        let rightAssociativityExpression = try MathExpression(String(format: Formula.AbelianMultiplicativeGroupAxiomTests.rightAssociativity, a, b, c))
        let expectedResult = Double(a) * Double(b) * Double(c)

        XCTAssertEqual(leftAssociativityExpression.evaluate(), rightAssociativityExpression.evaluate())
        XCTAssertEqual(leftAssociativityExpression.evaluate(), expectedResult)
    }

    func testCommutativity() throws {
        let a = Int16.random()
        let b = Int16.random()

        let firstExpression = try MathExpression(String(format: Formula.AbelianMultiplicativeGroupAxiomTests.commutativity, a, b))
        let secondExpression = try MathExpression(String(format: Formula.AbelianMultiplicativeGroupAxiomTests.commutativity, b, a))
        let expectedResult = Double(a) * Double(b)

        XCTAssertEqual(firstExpression.evaluate(), secondExpression.evaluate())
        XCTAssertEqual(firstExpression.evaluate(), expectedResult)
    }
}
