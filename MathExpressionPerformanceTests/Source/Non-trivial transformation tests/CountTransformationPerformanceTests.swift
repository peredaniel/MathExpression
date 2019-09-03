//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class CountTransformationPerformanceTests: XCTestCase {
    let transformation: (String) -> Double = { Double($0.count) }

    func testPerformanceProductOfAddition() {
        let a = Int16.random()
        let b = String.random(length: Int.random(in: 5...20))
        let c = Int16.random()
        let d = String.random(length: Int.random(in: 5...20))
        let formula = String(format: Formula.TransformationTests.productOfAddition, a, b, c, d)

        measure {
            let expression = try! MathExpression(formula, transformation: transformation)
            _ = expression.evaluate()
        }
    }

    func testPerformanceSquareOfAddition() {
        let a = Int16.random()
        let b = String.random(length: Int.random(in: 5...20))
        let formula = String(format: Formula.TransformationTests.productOfAddition, a, b, a, b)

        measure {
            let expression = try! MathExpression(formula, transformation: transformation)
            _ = expression.evaluate()
        }
    }

    func testPerformanceProductOfSubtraction() {
        let a = Int16.random()
        let b = String.random(length: Int.random(in: 5...20))
        let c = Int16.random()
        let d = String.random(length: Int.random(in: 5...20))
        let formula = String(format: Formula.TransformationTests.productOfSubtraction, a, b, c, d)

        measure {
            let expression = try! MathExpression(formula, transformation: transformation)
            _ = expression.evaluate()
        }
    }

    func testPerformanceSquareOfSubtraction() {
        let a = Int16.random()
        let b = String.random(length: Int.random(in: 5...20))
        let formula = String(format: Formula.TransformationTests.productOfSubtraction, a, b, a, b)

        measure {
            let expression = try! MathExpression(formula, transformation: transformation)
            _ = expression.evaluate()
        }
    }

    func testPerformanceProductOfAdditionWithSubtraction() {
        let a = Int16.random()
        let b = String.random(length: Int.random(in: 5...20))
        let c = Int16.random()
        let d = String.random(length: Int.random(in: 5...20))
        let formula = String(format: Formula.TransformationTests.productOfAdditionWithSubtraction, a, b, c, d)

        measure {
            let expression = try! MathExpression(formula, transformation: transformation)
            _ = expression.evaluate()
        }
    }

    func testPerformanceProductOfAdditionWithSubtractionIdentity() {
        let a = Int16.random()
        let b = String.random(length: Int.random(in: 5...20))
        let formula = String(format: Formula.TransformationTests.productOfAdditionWithSubtraction, a, b, a, b)

        measure {
            let expression = try! MathExpression(formula, transformation: transformation)
            _ = expression.evaluate()
        }
    }

    func testPerformanceDivisionOfAdditionWithSubtraction() {
        let a = Int16.random()
        let b = String.random(length: Int.random(in: 5...20))
        let c = Int16.random()
        let d = String.random(length: Int.random(in: 5...20))
        let formula = String(format: Formula.TransformationTests.divisionOfAdditionWithSubtraction, a, b, c, d)

        measure {
            let expression = try! MathExpression(formula, transformation: transformation)
            _ = expression.evaluate()
        }
    }

    func testPerformanceDivisionOfProductOfAdditionsWithProductOfSubtractions() {
        let a = Int16.random()
        let b = String.random(length: Int.random(in: 5...20))
        let c = Int16.random()
        let d = String.random(length: Int.random(in: 5...20))
        let e = Int16.random()
        let f = String.random(length: Int.random(in: 5...20))
        let g = Int16.random()
        let h = String.random(length: Int.random(in: 5...20))
        let formula = String(format: Formula.TransformationTests.divisionOfProductOfAdditionsWithProductOfSubtractions, a, b, c, d, e, f, g, h)

        measure {
            let expression = try! MathExpression(formula, transformation: transformation)
            _ = expression.evaluate()
        }
    }

    func testPerformanceDivisionOfCrossedProducts() {
        let a = Int16.random()
        let b = String.random(length: Int.random(in: 5...20))
        let c = Int16.random()
        let d = String.random(length: Int.random(in: 5...20))
        let e = Int16.random()
        let f = String.random(length: Int.random(in: 5...20))
        let g = Int16.random()
        let h = String.random(length: Int.random(in: 5...20))
        let formula = String(format: Formula.TransformationTests.divisionOfCrossedProducts, a, b, c, d, e, f, g, h)

        measure {
            let expression = try! MathExpression(formula, transformation: transformation)
            _ = expression.evaluate()
        }
    }
}
