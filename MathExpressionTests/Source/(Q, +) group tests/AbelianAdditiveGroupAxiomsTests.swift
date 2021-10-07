//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class AbelianAdditiveGroupAxiomsTests: XCTestCase {
    func testNeutralElement() throws {
        let a = Int16.random()
        let neutralElement: Int16 = .zero

        let leftNeutralExpression = try MathExpression(String(format: Formula.AbelianAdditiveGroupAxiomsTests.neutralElement, neutralElement, a))
        let rightNeutralExpression = try MathExpression(String(format: Formula.AbelianAdditiveGroupAxiomsTests.neutralElement, a, neutralElement))
        let expectedResult = Double(a)

        XCTAssertEqual(leftNeutralExpression.evaluate(), rightNeutralExpression.evaluate())
        XCTAssertEqual(leftNeutralExpression.evaluate(), expectedResult)
    }

    func testInverse() throws {
        let a = Int16.random()

        let inverseExpression = try MathExpression(String(format: Formula.AbelianAdditiveGroupAxiomsTests.inverseElement, a))
        let leftSumWithInverse = try MathExpression(String(format: Formula.AbelianAdditiveGroupAxiomsTests.leftInverse, a, a))
        let rightSumWithInverse = try MathExpression(String(format: Formula.AbelianAdditiveGroupAxiomsTests.rightInverse, a, a))
        let expectedResult = Double(a).negative

        XCTAssertEqual(inverseExpression.evaluate(), expectedResult)
        XCTAssertEqual(leftSumWithInverse.evaluate(), rightSumWithInverse.evaluate())
        XCTAssertEqual(leftSumWithInverse.evaluate(), .zero)
    }

    func testAssociativity() throws {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()

        let leftAssociativityExpression = try MathExpression(String(format: Formula.AbelianAdditiveGroupAxiomsTests.leftAssociativity, a, b, c))
        let rightAssociativityExpression = try MathExpression(String(format: Formula.AbelianAdditiveGroupAxiomsTests.rightAssociativity, a, b, c))
        let expectedResult = Double(a) + Double(b) + Double(c)

        XCTAssertEqual(leftAssociativityExpression.evaluate(), rightAssociativityExpression.evaluate())
        XCTAssertEqual(leftAssociativityExpression.evaluate(), expectedResult)
    }

    func testCommutativity() throws {
        let a = Int16.random()
        let b = Int16.random()

        let firstExpression = try MathExpression(String(format: Formula.AbelianAdditiveGroupAxiomsTests.commutativity, a, b))
        let secondExpression = try MathExpression(String(format: Formula.AbelianAdditiveGroupAxiomsTests.commutativity, b, a))
        let expectedResult = Double(a) + Double(b)

        XCTAssertEqual(firstExpression.evaluate(), secondExpression.evaluate())
        XCTAssertEqual(firstExpression.evaluate(), expectedResult)
    }
}
