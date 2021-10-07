//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class FactorialTransformationPerformanceTests: XCTestCase {
    let transformation: (String) -> Double = { string in
        guard string.last == "!", var number = Int(string.dropLast()) else { return .zero }
        return Double(number.factorial())
    }

    func testPerformanceProductOfAddition() {
        let a = Int16.random()
        let b = Int.random(in: 0...10)
        let c = Int16.random()
        let d = Int.random(in: 0...10)
        let formula = String(format: Formula.TransformationTests.productOfAddition, a, "\(b)!", c, "\(d)!")

        measure {
            let expression = try! MathExpression(formula, transformation: transformation)
            _ = expression.evaluate()
        }
    }

    func testPerformanceSquareOfAddition() {
        let a = Int16.random()
        let b = Int.random(in: 0...10)
        let formula = String(format: Formula.TransformationTests.productOfAddition, a, "\(b)!", a, "\(b)!")

        measure {
            let expression = try! MathExpression(formula, transformation: transformation)
            _ = expression.evaluate()
        }
    }

    func testPerformanceProductOfSubtraction() {
        let a = Int16.random()
        let b = Int.random(in: 0...10)
        let c = Int16.random()
        let d = Int.random(in: 0...10)
        let formula = String(format: Formula.TransformationTests.productOfSubtraction, a, "\(b)!", c, "\(d)!")

        measure {
            let expression = try! MathExpression(formula, transformation: transformation)
            _ = expression.evaluate()
        }
    }

    func testPerformanceSquareOfSubtraction() {
        let a = Int16.random()
        let b = Int.random(in: 0...10)
        let formula = String(format: Formula.TransformationTests.productOfSubtraction, a, "\(b)!", a, "\(b)!")

        measure {
            let expression = try! MathExpression(formula, transformation: transformation)
            _ = expression.evaluate()
        }
    }

    func testPerformanceProductOfAdditionWithSubtraction() {
        let a = Int16.random()
        let b = Int.random(in: 0...10)
        let c = Int16.random()
        let d = Int.random(in: 0...10)
        let formula = String(format: Formula.TransformationTests.productOfAdditionWithSubtraction, a, "\(b)!", c, "\(d)!")

        measure {
            let expression = try! MathExpression(formula, transformation: transformation)
            _ = expression.evaluate()
        }
    }

    func testPerformanceProductOfAdditionWithSubtractionIdentity() {
        let a = Int16.random()
        let b = Int.random(in: 0...10)
        let formula = String(format: Formula.TransformationTests.productOfAdditionWithSubtraction, a, "\(b)!", a, "\(b)!")

        measure {
            let expression = try! MathExpression(formula, transformation: transformation)
            _ = expression.evaluate()
        }
    }

    func testPerformanceDivisionOfAdditionWithSubtraction() {
        let a = Int16.random()
        let b = Int.random(in: 0...10)
        let c = Int16.random()
        let d = Int.random(in: 0...10)
        let formula = String(format: Formula.TransformationTests.divisionOfAdditionWithSubtraction, a, "\(b)!", c, "\(d)!")

        measure {
            let expression = try! MathExpression(formula, transformation: transformation)
            _ = expression.evaluate()
        }
    }

    func testPerformanceDivisionOfProductOfAdditionsWithProductOfSubtractions() {
        let a = Int16.random()
        let b = Int.random(in: 0...10)
        let c = Int16.random()
        let d = Int.random(in: 0...10)
        let e = Int16.random()
        let f = Int.random(in: 0...10)
        let g = Int16.random()
        let h = Int.random(in: 0...10)
        let formula = String(format: Formula.TransformationTests.divisionOfProductOfAdditionsWithProductOfSubtractions, a, "\(b)!", c, "\(d)!", e, "\(f)!", g, "\(h)!")

        measure {
            let expression = try! MathExpression(formula, transformation: transformation)
            _ = expression.evaluate()
        }
    }

    func testPerformanceDivisionOfCrossedProducts() {
        let a = Int16.random()
        let b = Int.random(in: 0...10)
        let c = Int16.random()
        let d = Int.random(in: 0...10)
        let e = Int16.random()
        let f = Int.random(in: 0...10)
        let g = Int16.random()
        let h = Int.random(in: 0...10)
        let formula = String(format: Formula.TransformationTests.divisionOfCrossedProducts, a, "\(b)!", c, "\(d)!", e, "\(f)!", g, "\(h)!")

        measure {
            let expression = try! MathExpression(formula, transformation: transformation)
            _ = expression.evaluate()
        }
    }
}

private extension Int {
    func factorial() -> Int {
        guard self > 1 else { return 1 }
        return self * (self - 1).factorial()
    }
}
