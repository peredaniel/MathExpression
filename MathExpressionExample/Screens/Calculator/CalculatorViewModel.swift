//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

class CalculatorViewModel {
    private(set) weak var delegate: MathExpressionViewModelDelegate?

    private(set) var expression = "" {
        didSet { delegate?.didUpdateExpression(self) }
    }

    private(set) var transformation: MathTransformation = .numericValueOrZero

    init(delegate: MathExpressionViewModelDelegate) {
        self.delegate = delegate
    }
}

extension CalculatorViewModel: MathExpressionViewModel {
    func clearExpression() {
        expression = ""
    }

    func updateExpression(_ newCharacters: String?) {
        guard let newCharacters = newCharacters else { return }
        if !expression.isEmpty, expression.last != "(", newCharacters != ")" {
            expression += " \(newCharacters)"
        } else {
            expression += newCharacters
        }
    }

    func updateTransformation(_: MathTransformation) {}
}
