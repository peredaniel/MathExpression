//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

@testable import MathExpression
import XCTest

class FieldAxiomPerformanceTests: XCTestCase {
    func testPerformanceDistributivityOfProductOverAddition() {
        let a = Int16.random()
        let b = Int16.random()
        let c = Int16.random()

        measure {
            let leftDistributivityFactoredExpression = try! MathExpression(String(format: Formula.FieldAxiomTests.leftDistributivityFactored, a, b, c))
            _ = leftDistributivityFactoredExpression.evaluate()

            let rightDistributivityFactoredExpression = try! MathExpression(String(format: Formula.FieldAxiomTests.rightDistributivityFactored, a, b, c))
            _ = rightDistributivityFactoredExpression.evaluate()

            let distributivityExpandedExpression = try! MathExpression(String(format: Formula.FieldAxiomTests.distributivityExpanded, a, c, b, c))
            _ = distributivityExpandedExpression.evaluate()
        }
    }
}
