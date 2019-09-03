//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class CountTransformationTests: XCTestCase {
    let transformation: (String) -> Double = { Double($0.count) }

    func testProductOfAddition() {
        let a = Int16.random()
        let b = String.random(length: Int.random(in: 5...20))
        let c = Int16.random()
        let d = String.random(length: Int.random(in: 5...20))

        let formula = String(format: Formula.TransformationTests.productOfAddition, a, b, c, d)
        let expression = try! MathExpression(formula, transformation: transformation)
        let expectedResult = (Double(a) + Double(b.count)) * (Double(c) + Double(d.count))

        XCTAssertEqual(expression.evaluate(), expectedResult)
    }

    func testSquareOfAddition() {
        let a = Int16.random()
        let b = String.random(length: Int.random(in: 5...20))

        let formula = String(format: Formula.TransformationTests.productOfAddition, a, b, a, b)
        let expression = try! MathExpression(formula, transformation: transformation)
        let expectedResult = pow(Double(a) + Double(b.count), 2.0)

        XCTAssertEqual(expression.evaluate(), expectedResult)
    }

    func testProductOfSubtraction() {
        let a = Int16.random()
        let b = String.random(length: Int.random(in: 5...20))
        let c = Int16.random()
        let d = String.random(length: Int.random(in: 5...20))

        let formula = String(format: Formula.TransformationTests.productOfSubtraction, a, b, c, d)
        let expression = try! MathExpression(formula, transformation: transformation)
        let expectedResult = (Double(a) - Double(b.count)) * (Double(c) - Double(d.count))

        XCTAssertEqual(expression.evaluate(), expectedResult)
    }

    func testSquareOfSubtraction() {
        let a = Int16.random()
        let b = String.random(length: Int.random(in: 5...20))

        let formula = String(format: Formula.TransformationTests.productOfSubtraction, a, b, a, b)
        let expression = try! MathExpression(formula, transformation: transformation)
        let expectedResult = pow(Double(a) - Double(b.count), 2.0)

        XCTAssertEqual(expression.evaluate(), expectedResult)
    }

    func testProductOfAdditionWithSubtraction() {
        let a = Int16.random()
        let b = String.random(length: Int.random(in: 5...20))
        let c = Int16.random()
        let d = String.random(length: Int.random(in: 5...20))

        let formula = String(format: Formula.TransformationTests.productOfAdditionWithSubtraction, a, b, c, d)
        let expression = try! MathExpression(formula, transformation: transformation)
        let expectedResult = (Double(a) + Double(b.count)) * (Double(c) - Double(d.count))

        XCTAssertEqual(expression.evaluate(), expectedResult)
    }

    func testProductOfAdditionWithSubtractionIdentity() {
        let a = Int16.random()
        let b = String.random(length: Int.random(in: 5...20))

        let formula = String(format: Formula.TransformationTests.productOfAdditionWithSubtraction, a, b, a, b)
        let expression = try! MathExpression(formula, transformation: transformation)
        let expectedResult = pow(Double(a), 2.0) - pow(Double(b.count), 2.0)

        XCTAssertEqual(expression.evaluate(), expectedResult)
    }

    func testDivisionOfAdditionWithSubtraction() {
        let a = Int16.random()
        let b = String.random(length: Int.random(in: 5...20))
        let c = Int16.random()
        let d = String.random(length: Int.random(in: 5...20))

        let formula = String(format: Formula.TransformationTests.divisionOfAdditionWithSubtraction, a, b, c, d)
        let expression = try! MathExpression(formula, transformation: transformation)
        let expectedResult = (Double(a) + Double(b.count)) / (Double(c) - Double(d.count))

        XCTAssertEqual(expression.evaluate(), expectedResult)
    }

    func testDivisionOfProductOfAdditionsWithProductOfSubtractions() {
        let a = Int16.random()
        let b = String.random(length: Int.random(in: 5...20))
        let c = Int16.random()
        let d = String.random(length: Int.random(in: 5...20))
        let e = Int16.random()
        let f = String.random(length: Int.random(in: 5...20))
        let g = Int16.random()
        let h = String.random(length: Int.random(in: 5...20))

        let formula = String(format: Formula.TransformationTests.divisionOfProductOfAdditionsWithProductOfSubtractions, a, b, c, d, e, f, g, h)
        let expression = try! MathExpression(formula, transformation: transformation)
        let expectedResult = (Double(a) + Double(b.count)) * (Double(c) + Double(d.count)) / ((Double(e) - Double(f.count)) * (Double(g) - Double(h.count)))

        XCTAssertEqual(expression.evaluate().rounded(toPlaces: 6), expectedResult.rounded(toPlaces: 6))
    }

    func testDivisionOfCrossedProducts() {
        let a = Int16.random()
        let b = String.random(length: Int.random(in: 5...20))
        let c = Int16.random()
        let d = String.random(length: Int.random(in: 5...20))
        let e = Int16.random()
        let f = String.random(length: Int.random(in: 5...20))
        let g = Int16.random()
        let h = String.random(length: Int.random(in: 5...20))

        let formula = String(format: Formula.TransformationTests.divisionOfCrossedProducts, a, b, c, d, e, f, g, h)
        let expression = try! MathExpression(formula, transformation: transformation)
        let expectedResult = (Double(a) + Double(b.count)) * (Double(c) - Double(d.count)) / ((Double(e) + Double(f.count)) * (Double(g) - Double(h.count)))

        XCTAssertEqual(expression.evaluate().rounded(toPlaces: 6), expectedResult.rounded(toPlaces: 6))
    }
}
