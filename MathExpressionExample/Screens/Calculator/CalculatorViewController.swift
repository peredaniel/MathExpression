//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

import UIKit

// MARK: - Class declaration

class CalculatorViewController: UIViewController {
    // Outlets

    @IBOutlet private var expressionLabel: UILabel!
    @IBOutlet private var newCharactersLabel: UILabel!
    @IBOutlet private var clearExpressionButton: UIButton!

    // Properties

    private var shouldClearNewCharactersOnNextTap: Bool = false
    private lazy var viewModel: MathExpressionViewModel = CalculatorViewModel(delegate: self)

    // Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        expressionLabel.text = ""
        newCharactersLabel.text = "0"
    }
}

// MARK: - Delegate conformance

extension CalculatorViewController: MathExpressionViewModelDelegate {
    func didEvaluateExpression(_ result: Result<String, ValidationError>) {
        switch result {
        case .success(let value):
            newCharactersLabel.text = value
            viewModel.updateExpression("=")
            shouldClearNewCharactersOnNextTap = true
        case .failure(let error):
            let alertController = UIAlertController(
                title: "Validation error",
                message: error.description,
                preferredStyle: .alert
            )
            let closeAction = UIAlertAction(title: "Ok", style: .default) { _ in
                alertController.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(closeAction)
            present(alertController, animated: true, completion: nil)
        }
    }

    func didUpdateExpression(_ viewModel: MathExpressionViewModel) {
        expressionLabel.text = viewModel.expression
    }
}

// MARK: - Private API

private extension CalculatorViewController {
    @IBAction func evaluateExpression() {
        if let expression = expressionLabel.text, expression.last != ")" {
            viewModel.updateExpression(newCharactersLabel.text)
        }
        viewModel.evaluateExpression()
    }

    @IBAction func toggleSign() {
        guard let newCharacters = newCharactersLabel.text else { return }
        if newCharacters.starts(with: "-") {
            newCharactersLabel.text = String(newCharacters.dropFirst())
        } else {
            newCharactersLabel.text = "-\(newCharacters)"
        }
    }

    @IBAction func addNumber(_ sender: UIButton) {
        guard let newCharacters = newCharactersLabel.text,
            let number = sender.titleLabel?.text
        else {
            return
        }
        if newCharacters == "0" || shouldClearNewCharactersOnNextTap {
            newCharactersLabel.text = sender.titleLabel?.text
            clearExpressionButton.titleLabel?.text = "C"
            shouldClearNewCharactersOnNextTap = false
        } else {
            newCharactersLabel.text = newCharacters + number
        }
    }

    @IBAction func addOperator(_ sender: UIButton) {
        if shouldClearNewCharactersOnNextTap {
            viewModel.clearExpression()
        }
        if expressionLabel.text?.last != ")" {
            viewModel.updateExpression(newCharactersLabel.text)
        }
        viewModel.updateExpression(sender.titleLabel?.text)
        shouldClearNewCharactersOnNextTap = true
    }

    @IBAction func addBracket(_ sender: UIButton) {
        guard let bracket = sender.titleLabel?.text else { return }
        if bracket == ")" {
            viewModel.updateExpression(newCharactersLabel.text)
        } else {
            shouldClearNewCharactersOnNextTap = true
        }
        viewModel.updateExpression(sender.titleLabel?.text)
    }

    @IBAction func clearExpression(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        if title == "AC" {
            newCharactersLabel.text = "0"
            viewModel.clearExpression()
        } else {
            newCharactersLabel.text = "0"
            sender.titleLabel?.text = "AC"
        }
    }

    @IBAction func addDecimalOperator() {
        guard let newCharacters = newCharactersLabel.text else { return }
        newCharactersLabel.text = newCharacters + "."
    }
}
