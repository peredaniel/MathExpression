//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class FactorialTransformationTests: XCTestCase {
    let transformation: (String) -> Double = { string in
        guard string.last == "!", let number = Int(string.dropLast()) else { return .zero }
        return Double(number.factorial())
    }

    func testProductOfAddition() throws {
        let a = Int16.random()
        let b = Int.random(in: 0...10)
        let c = Int16.random()
        let d = Int.random(in: 0...10)

        let formula = String(format: Formula.TransformationTests.productOfAddition, a, "\(b)!", c, "\(d)!")
        let expression = try MathExpression(formula, transformation: transformation)
        let expectedResult = (Double(a) + Double(b.factorial())) * (Double(c) + Double(d.factorial()))

        XCTAssertEqual(expression.evaluate(), expectedResult)
    }

    func testSquareOfAddition() throws {
        let a = Int16.random()
        let b = Int.random(in: 0...10)

        let formula = String(format: Formula.TransformationTests.productOfAddition, a, "\(b)!", a, "\(b)!")
        let expression = try MathExpression(formula, transformation: transformation)
        let expectedResult = pow(Double(a) + Double(b.factorial()), 2.0)

        XCTAssertEqual(expression.evaluate(), expectedResult)
    }

    func testProductOfSubtraction() throws {
        let a = Int16.random()
        let b = Int.random(in: 0...10)
        let c = Int16.random()
        let d = Int.random(in: 0...10)

        let formula = String(format: Formula.TransformationTests.productOfSubtraction, a, "\(b)!", c, "\(d)!")
        let expression = try MathExpression(formula, transformation: transformation)
        let expectedResult = (Double(a) - Double(b.factorial())) * (Double(c) - Double(d.factorial()))

        XCTAssertEqual(expression.evaluate(), expectedResult)
    }

    func testSquareOfSubtraction() throws {
        let a = Int16.random()
        let b = Int.random(in: 0...10)

        let formula = String(format: Formula.TransformationTests.productOfSubtraction, a, "\(b)!", a, "\(b)!")
        let expression = try MathExpression(formula, transformation: transformation)
        let expectedResult = pow(Double(a) - Double(b.factorial()), 2.0)

        XCTAssertEqual(expression.evaluate(), expectedResult)
    }

    func testProductOfAdditionWithSubtraction() throws {
        let a = Int16.random()
        let b = Int.random(in: 0...10)
        let c = Int16.random()
        let d = Int.random(in: 0...10)

        let formula = String(format: Formula.TransformationTests.productOfAdditionWithSubtraction, a, "\(b)!", c, "\(d)!")
        let expression = try MathExpression(formula, transformation: transformation)
        let expectedResult = (Double(a) + Double(b.factorial())) * (Double(c) - Double(d.factorial()))

        XCTAssertEqual(expression.evaluate(), expectedResult)
    }

    func testProductOfAdditionWithSubtractionIdentity() throws {
        let a = Int16.random()
        let b = Int.random(in: 0...10)

        let formula = String(format: Formula.TransformationTests.productOfAdditionWithSubtraction, a, "\(b)!", a, "\(b)!")
        let expression = try MathExpression(formula, transformation: transformation)
        let expectedResult = pow(Double(a), 2.0) - pow(Double(b.factorial()), 2.0)

        XCTAssertEqual(expression.evaluate(), expectedResult)
    }

    func testDivisionOfAdditionWithSubtraction() throws {
        let a = Int16.random()
        let b = Int.random(in: 0...10)
        let c = Int16.random()
        let d = Int.random(in: 0...10)

        let formula = String(format: Formula.TransformationTests.divisionOfAdditionWithSubtraction, a, "\(b)!", c, "\(d)!")
        let expression = try MathExpression(formula, transformation: transformation)
        let expectedResult = (Double(a) + Double(b.factorial())) / (Double(c) - Double(d.factorial()))

        XCTAssertEqual(expression.evaluate(), expectedResult)
    }

    func testDivisionOfProductOfAdditionsWithProductOfSubtractions() throws {
        let a = Int16.random()
        let b = Int.random(in: 0...10)
        let c = Int16.random()
        let d = Int.random(in: 0...10)
        let e = Int16.random()
        let f = Int.random(in: 0...10)
        let g = Int16.random()
        let h = Int.random(in: 0...10)

        let formula = String(format: Formula.TransformationTests.divisionOfProductOfAdditionsWithProductOfSubtractions, a, "\(b)!", c, "\(d)!", e, "\(f)!", g, "\(h)!")
        let expression = try MathExpression(formula, transformation: transformation)
        let expectedResult = (Double(a) + Double(b.factorial())) * (Double(c) + Double(d.factorial())) / ((Double(e) - Double(f.factorial())) * (Double(g) - Double(h.factorial())))

        XCTAssertEqual(expression.evaluate().rounded(toPlaces: 6), expectedResult.rounded(toPlaces: 6))
    }

    func testDivisionOfCrossedProducts() throws {
        let a = Int16.random()
        let b = Int.random(in: 0...10)
        let c = Int16.random()
        let d = Int.random(in: 0...10)
        let e = Int16.random()
        let f = Int.random(in: 0...10)
        let g = Int16.random()
        let h = Int.random(in: 0...10)

        let formula = String(format: Formula.TransformationTests.divisionOfCrossedProducts, a, "\(b)!", c, "\(d)!", e, "\(f)!", g, "\(h)!")
        let expression = try MathExpression(formula, transformation: transformation)
        let expectedResult = (Double(a) + Double(b.factorial())) * (Double(c) - Double(d.factorial())) / ((Double(e) + Double(f.factorial())) * (Double(g) - Double(h.factorial())))

        XCTAssertEqual(expression.evaluate().rounded(toPlaces: 6), expectedResult.rounded(toPlaces: 6))
    }
}

private extension Int {
    func factorial() -> Int {
        guard self > 1 else { return 1 }
        return self * (self - 1).factorial()
    }
}
