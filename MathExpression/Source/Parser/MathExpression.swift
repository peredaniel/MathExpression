//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

import Foundation

public struct MathExpression {
    public enum ValidationError: Error {
        case emptyExpression
        case misplacedBrackets
        case unevenOpeningClosingBracketNumber
        case consecutiveMultiplicativeOperators(String)
        case startsWithNonSumOrSubtractionOperator(String)
        case endsWithOperator(String)
    }

    private let formula: MathFormula

    public init(
        _ string: String,
        transformation: ((String) -> Double)? = nil
    ) throws {
        formula = try MathFormula(string, transformation: transformation)
    }

    internal init(
        validString string: String,
        transformation: @escaping (String) -> Double
    ) {
        formula = MathFormula(validString: string, transformation: transformation)
    }

    public func evaluate() -> Double {
        switch formula.evaluationState() {
        case .isNumeric(let value):
            return value
        case .startsWithSymbol(let symbol):
            switch symbol {
            case .sum, .product:
                return formula.dropingInitialValue().evaluate()
            case .division:
                return formula.addingInitialValue(for: symbol).evaluate()
            case .subtraction:
                return formula.replaceSubtractionByNegative().evaluate()
            case .negative:
                return formula.dropingInitialValue().evaluate().negative
            }
        case .containsBracket(let brackets):
            return formula.evaluatingExpression(between: brackets).evaluate()
        case .canApplyOperator(let mathOperator):
            return mathOperator.apply(to: formula.decompose(with: mathOperator).evaluate())
        case .canApplyTransformation:
            return formula.applyTransformation()
        }
    }
}

private extension Array where Element == MathExpression {
    func evaluate() -> [Double] {
        return map { $0.evaluate() }
    }
}
