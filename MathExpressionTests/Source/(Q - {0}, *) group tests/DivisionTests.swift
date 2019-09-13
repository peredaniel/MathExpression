//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

// Most operation results in this class are rounded to avoid intrinsic computation errors.
// We consider that results which are off by 10^(-6) or less are acceptable errors inherent
// to floating value computations and not the algorithm itself.

class DivisionTests: XCTestCase {
    func testSimpleDivision() {
        let a = Int16.random()
        let b = Int16.random()
        let operation = Operation(
            String(format: Formula.DivisionTests.simpleDivision, a, b),
            expectedResult: Double(a) / Double(b)
        )
        XCTAssertEqual(operation.compute().rounded(toPlaces: 6), operation.expectedResult.rounded(toPlaces: 6))
    }

    func testSimpleDivisionWithParentheses() {
        let a = Int16.random()
        let b = Int16.random()
        let operation = Operation(
            String(format: Formula.DivisionTests.simpleDivisionWithParentheses, a, b),
            expectedResult: Double(a) / Double(b)
        )
        XCTAssertEqual(operation.compute().rounded(toPlaces: 6), operation.expectedResult.rounded(toPlaces: 6))
    }

    func testSimpleDivisionWithParenthesesWithInitialDivision() {
        let a = Int16.random()
        let b = Int16.random()
        let operation = Operation(
            String(format: Formula.DivisionTests.simpleDivisionWithParenthesesWithInitialDivision, a, b),
            expectedResult: 1.0 / (Double(a) / Double(b))
        )
        XCTAssertEqual(operation.compute().rounded(toPlaces: 6), operation.expectedResult.rounded(toPlaces: 6))
    }

    func testComplicatedDivision() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let operation = Operation(
            String(format: Formula.DivisionTests.complicatedDivision, a, b, c),
            expectedResult: Double(a) / Double(b) / Double(c)
        )
        XCTAssertEqual(operation.compute().rounded(toPlaces: 6), operation.expectedResult.rounded(toPlaces: 6))
    }

    func testDivideSingleNumber() {
        let a = Int16.random()
        let operation = Operation(
            String(format: Formula.DivisionTests.divideSingleNumber, a),
            expectedResult: 1.0 / Double(a)
        )
        XCTAssertEqual(operation.compute().rounded(toPlaces: 6), operation.expectedResult.rounded(toPlaces: 6))
    }

    func testConsecutiveDivisionExpressionWithInitialDivision() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let operation = Operation(
            String(format: Formula.DivisionTests.consecutiveDivisionExpressionWithInitialDivision, a, b, c),
            expectedResult: 1.0 / Double(a) / Double(b) / Double(c)
        )
        XCTAssertEqual(operation.compute().rounded(toPlaces: 6), operation.expectedResult.rounded(toPlaces: 6))
    }
}
