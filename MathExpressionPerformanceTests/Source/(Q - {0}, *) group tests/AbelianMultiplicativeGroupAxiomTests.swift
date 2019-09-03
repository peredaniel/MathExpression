//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class AbelianMultiplicativeGroupAxiomPerformanceTests: XCTestCase {
    func testPerformanceNeutralElement() {
        let a = Int16.random()
        let neutralElement: Int16 = 1

        measure {
            let leftNeutralExpression = try! MathExpression(String(format: Formula.AbelianMultiplicativeGroupAxiomTests.neutralElement, neutralElement, a))
            _ = leftNeutralExpression.evaluate()

            let rightNeutralExpression = try! MathExpression(String(format: Formula.AbelianMultiplicativeGroupAxiomTests.neutralElement, a, neutralElement))
            _ = rightNeutralExpression.evaluate()
        }
    }

    func testPerformanceInverse() {
        let a = Int16.random()

        measure {
            let inverseExpression = try! MathExpression(String(format: Formula.AbelianMultiplicativeGroupAxiomTests.inverseElement, a))
            _ = inverseExpression.evaluate()

            let leftProductWithInverse = try! MathExpression(String(format: Formula.AbelianMultiplicativeGroupAxiomTests.leftInverse, a, a))
            _ = leftProductWithInverse.evaluate()

            let rightProductWithInverse = try! MathExpression(String(format: Formula.AbelianMultiplicativeGroupAxiomTests.rightInverse, a, a))
            _ = rightProductWithInverse.evaluate()
        }
    }

    func testPerformanceAssociativity() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()

        measure {
            let leftAssociativityExpression = try! MathExpression(String(format: Formula.AbelianMultiplicativeGroupAxiomTests.leftAssociativity, a, b, c))
            _ = leftAssociativityExpression.evaluate()

            let rightAssociativityExpression = try! MathExpression(String(format: Formula.AbelianMultiplicativeGroupAxiomTests.rightAssociativity, a, b, c))
            _ = rightAssociativityExpression.evaluate()
        }
    }

    func testPerformanceCommutativity() {
        let a = Int16.random()
        let b = Int16.random()

        measure {
            let firstExpression = try! MathExpression(String(format: Formula.AbelianMultiplicativeGroupAxiomTests.commutativity, a, b))
            _ = firstExpression.evaluate()

            let secondExpression = try! MathExpression(String(format: Formula.AbelianMultiplicativeGroupAxiomTests.commutativity, b, a))
            _ = secondExpression.evaluate()
        }
    }
}
