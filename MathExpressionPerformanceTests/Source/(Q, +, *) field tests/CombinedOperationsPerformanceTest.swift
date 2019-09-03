//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class CombinedOperationsPerformanceTests: XCTestCase {
    func testPerformanceProductOfAddition() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.CombinedOperationsTests.productOfAddition, a, b, c, d))
            _ = expression.evaluate()
        }
    }

    func testPerformanceSquareOfAddition() {
        let a = Int16.random()
        let b = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.CombinedOperationsTests.productOfAddition, a, b, a, b))
            _ = expression.evaluate()
        }
    }

    func testPerformanceProductOfSubtraction() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.CombinedOperationsTests.productOfSubtraction, a, b, c, d))
            _ = expression.evaluate()
        }
    }

    func testPerformanceSquareOfSubtraction() {
        let a = Int16.random()
        let b = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.CombinedOperationsTests.productOfSubtraction, a, b, a, b))
            _ = expression.evaluate()
        }
    }

    func testPerformanceProductOfAdditionWithSubtraction() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.randomExcluding(c)

        measure {
            let expression = try! MathExpression(String(format: Formula.CombinedOperationsTests.productOfAdditionWithSubtraction, a, b, c, d))
            _ = expression.evaluate()
        }
    }

    func testPerformanceProductOfAdditionWithSubtractionIdentity() {
        let a = Int16.random()
        let b = Int16.random()

        measure {
            let expression = try! MathExpression(String(format: Formula.CombinedOperationsTests.productOfAdditionWithSubtraction, a, b, a, b))
            _ = expression.evaluate()
        }
    }

    func testPerformanceDivisionOfAdditionWithSubtraction() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.randomExcluding(c)

        measure {
            let expression = try! MathExpression(String(format: Formula.CombinedOperationsTests.divisionOfAdditionWithSubtraction, a, b, c, d))
            _ = expression.evaluate()
        }
    }

    func testPerformanceDivisionOfProductOfAdditionsWithProductOfSubtractions() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()
        let e = Int16.random()
        let f = Int16.randomExcluding(e)
        let g = Int16.random()
        let h = Int16.randomExcluding(g)

        measure {
            let expression = try! MathExpression(String(format: Formula.CombinedOperationsTests.divisionOfProductOfAdditionsWithProductOfSubtractions, a, b, c, d, e, f, g, h))
            _ = expression.evaluate()
        }
    }

    func testPerformanceDivisionOfCrossedProducts() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()
        let d = Int16.random()
        let e = Int16.random()
        let f = Int16.random()
        let g = Int16.random()
        let h = Int16.randomExcluding(g)

        measure {
            let expression = try! MathExpression(String(format: Formula.CombinedOperationsTests.divisionOfCrossedProducts, a, b, c, d, e, f, g, h))
            _ = expression.evaluate()
        }
    }
}
