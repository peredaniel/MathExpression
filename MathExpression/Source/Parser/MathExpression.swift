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
        transformation: @escaping (String) -> Double = { Double($0) ?? .zero }
    ) throws {
        formula = try MathFormula(string, transformation: transformation)
    }

    internal init(_ formula: MathFormula) {
        self.formula = formula
    }

    public func evaluate() -> Double {
        switch formula.evaluationState() {
        case .isNumeric(let value):
            return value
        case .startsWithSymbol(let symbol):
            switch symbol {
            case .sum:
                return MathExpression(formula.dropingInitialValue()).evaluate()
            case .subtraction:
                return MathExpression(formula.replaceSubtractionByNegative()).evaluate()
            }
        case .containsBracket(let brackets):
            return MathExpression(formula.evaluatingExpression(between: brackets)).evaluate()
        case .canApplyOperator(let mathOperator):
            return mathOperator.apply(
                to: formula.decompose(with: mathOperator).map { MathExpression($0) }.evaluate()
            )
        case .canApplyTransformation:
            return formula.applyTransformation()
        }
    }
}

private extension Array where Element == MathExpression {
    func evaluate() -> [Double] {
        map { $0.evaluate() }
    }
}
