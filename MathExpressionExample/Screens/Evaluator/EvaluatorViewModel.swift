//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

class EvaluatorViewModel {
    private(set) weak var delegate: MathExpressionViewModelDelegate?

    private(set) var expression = "" {
        didSet { delegate?.didUpdateExpression(self) }
    }

    private(set) var transformation: MathTransformation = .numericValueOrZero

    init(delegate: MathExpressionViewModelDelegate) {
        self.delegate = delegate
    }
}

extension EvaluatorViewModel: MathExpressionViewModel {
    func clearExpression() {
        expression = ""
    }

    func updateExpression(_ newExpression: String?) {
        guard let newExpression = newExpression else { return }
        expression = newExpression
    }

    func updateTransformation(_ transformation: MathTransformation) {
        self.transformation = transformation
    }
}
