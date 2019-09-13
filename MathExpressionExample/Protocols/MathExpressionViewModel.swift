//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

import MathExpression

protocol MathExpressionViewModelDelegate: AnyObject {
    func didEvaluateExpression(_: Result<String, ValidationError>)
    func didUpdateExpression(_: MathExpressionViewModel)
}

protocol MathExpressionViewModel: AnyObject {
    var delegate: MathExpressionViewModelDelegate? { get }
    var expression: String { get }
    var transformation: MathTransformation { get }

    func clearExpression()
    func evaluateExpression()
    func updateExpression(_: String?)
    func updateTransformation(_: MathTransformation)
}

extension MathExpressionViewModel {
    func evaluateExpression() {
        do {
            let mathExpression = try MathExpression(expression, transformation: transformation.function)
            let result = Formatter.mathExpression.string(from: NSNumber(value: mathExpression.evaluate())) ?? ""
            delegate?.didEvaluateExpression(.success(result))
        } catch {
            guard let error = error as? MathExpression.ValidationError else { fatalError() }
            let calculatorError: ValidationError
            switch error {
            case .emptyExpression:
                calculatorError = ValidationError("The expression is empty!")
            case .misplacedBrackets:
                calculatorError = ValidationError("There is a bracket out of place.")
            case .unevenOpeningClosingBracketNumber:
                calculatorError = ValidationError("The number of opening and closing brackets is uneven!")
            case .consecutiveMultiplicativeOperators(let value):
                calculatorError = ValidationError("The combination of operators \(value) is not valid.")
            case .startsWithNonSumOrSubtractionOperator(let value):
                calculatorError = ValidationError("The expression can not start with the \(value) operator.")
            case .endsWithOperator(let value):
                calculatorError = ValidationError("The expression can not end with the \(value) operator.")
            }
            delegate?.didEvaluateExpression(.failure(calculatorError))
        }
    }
}
