//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

import MathExpression

struct Operation {
    private let expression: MathExpression
    let expectedResult: Double

    init(_ expression: String, expectedResult: Double) {
        self.expression = try! MathExpression(expression)
        self.expectedResult = expectedResult
    }

    func compute() -> Double {
        return expression.evaluate()
    }
}
