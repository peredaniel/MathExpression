//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

// These tests intend to show that we can define mathematical functions as the transformation passed to the
// expression... with some drawbacks. The most important fact to remember is that transformations are applied
// LAST, that is, when the string is not a number and there are no operators or parentheses, then the parser
// calls the transformation function.
//
// This means that, depending on the transformation, we can have limitations or even get wrong results.
// In these tests, we use an exponentiation transformation to prove these facts. Due to the order in which
// operations are performed, it only works properly with non-negative bases and non-negative exponents.
//
// Negative bases will always return a negative result, independently of the exponent, since subtractions are processed first.
// Negative exponents must be explicitly expressed as '1 / (a ^ b)', with b >= 0.

class ExponentialTransformationTests: XCTestCase {
    let transformation: (String) -> Double = { string in
        let splitString = string.split(separator: "^").map { String($0) }
        guard splitString.count == 2,
            let base = try? MathExpression(splitString.first ?? ""),
            let exponent = try? MathExpression(splitString.last ?? "") else { return 0.0 }
        return pow(base.evaluate(), exponent.evaluate())
    }

    // MARK: - Satisfied identities

    func testSimpleAdditionOfExponentials() {
        let a = Int16.random(in: 0...100)
        let b = Int16.random(in: 1...4)
        let c = Int16.random(in: 0...8)
        let d = Int16.random(in: 1...15)

        let expression = try! MathExpression("(\(a) ^ \(b)) + (\(c) ^ \(d))", transformation: transformation)
        let expectedResult = pow(Double(a), Double(b)) + pow(Double(c), Double(d))
        XCTAssertEqual(expression.evaluate(), expectedResult)
    }

    func testAdditionOfExponents() {
        let a = Int16.random(in: 0...10)
        let b = Int16.random(in: 1...7)
        let c = Int16.random(in: 1...7)

        let expression = try! MathExpression("(\(a)^\(b)) * (\(a)^\(c))", transformation: transformation)
        let expandedExpression = try! MathExpression("\(a) ^ (\(b) + \(c))", transformation: transformation)
        let expectedResult = pow(Double(a), Double(b) + Double(c))
        XCTAssertEqual(expression.evaluate(), expandedExpression.evaluate())
        XCTAssertEqual(expression.evaluate(), expectedResult)
    }

    func testAdditionOfBases() {
        let a = Int16.random(in: 0...50)
        let b = Int16.random(in: 0...50)
        let c = Int16.random(in: 1...5)

        let expression = try! MathExpression("(\(a) + \(b)) ^ \(c)", transformation: transformation)
        let expectedResult = pow(Double(a) + Double(b), Double(c))
        XCTAssertEqual(expression.evaluate(), expectedResult)
    }

    func testSimpleProductOfBasesExponentials() {
        let a = Int16.random(in: 0...50)
        let b = Int16.random(in: 1...5)
        let c = Int16.random(in: 0...10)
        let d = Int16.random(in: 1...8)

        let expression = try! MathExpression("(\(a)^\(b)) * (\(c)^\(d))", transformation: transformation)
        let expectedResult = pow(Double(a), Double(b)) * pow(Double(c), Double(d))
        XCTAssertEqual(expression.evaluate(), expectedResult)
    }

    func testExponentialOfExponential() {
        let a = Int16.random(in: 0...10)
        let b = Int16.random(in: 0...7)
        let c = Int16.random(in: 1...7)

        let expression = try! MathExpression("(\(a) ^ \(b)) ^ \(c)", transformation: transformation)
        let expandedExpression = try! MathExpression("\(a) ^ (\(b) * \(c))", transformation: transformation)
        let expectedResult = pow(pow(Double(a), Double(b)), Double(c))
        XCTAssertEqual(expression.evaluate(), expandedExpression.evaluate())
        XCTAssertEqual(expression.evaluate(), expectedResult)
    }

    // MARK: - Non-satisfied idendities

    func testNegativeBaseWithEvenExponentGivesWrongResult() {
        let a = Int16.random(in: -20...0)
        let b = Int16.randomEven(in: 1...6)

        let expression = try! MathExpression("\(a)^\(b)", transformation: transformation)
        let expectedResult = pow(Double(a), Double(b))
        XCTAssertNotEqual(expression.evaluate(), expectedResult)
    }

    func testNegativeExponentGivesWrongResult() {
        let a = Int16.random(in: 0...20)
        let b = Int16.random(in: 1...6)

        let expression = try! MathExpression("\(a)^(-\(b))", transformation: transformation)
        let expandedExpression = try! MathExpression("1 / (\(a)^\(b))", transformation: transformation)
        let expectedResult = Double(1) / pow(Double(a), Double(b))
        XCTAssertNotEqual(expression.evaluate(), expandedExpression.evaluate())
        XCTAssertNotEqual(expression.evaluate(), expectedResult)
        XCTAssertEqual(expandedExpression.evaluate(), expectedResult)
    }
}
