//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

import UIKit

// MARK: - Class declaration

class EvaluatorViewController: UIViewController {
    // Outlets
    @IBOutlet private var expressionTextField: UITextField!
    @IBOutlet private var transformationTextField: UITextField!
    @IBOutlet private var evaluateButton: UIButton!
    @IBOutlet private var resultLabel: UILabel!

    // Properties
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()

    private lazy var viewModel: MathExpressionViewModel = EvaluatorViewModel(delegate: self)

    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        expressionTextField.text = nil
        transformationTextField.inputView = pickerView
        transformationTextField.text = viewModel.transformation.name
    }
}

// MARK: - View Model delegate conformance

extension EvaluatorViewController: MathExpressionViewModelDelegate {
    func didEvaluateExpression(_ result: Result<String, ValidationError>) {
        switch result {
        case .success(let value):
            resultLabel.text = "The evaluation result is: \(value)"
        case .failure(let error):
            resultLabel.text = "The expression is not valid."
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

    func didUpdateExpression(_: MathExpressionViewModel) {
        resultLabel.text = nil
    }
}

// MARK: - UIPickerView data source conformance

extension EvaluatorViewController: UIPickerViewDataSource {
    func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }

    func pickerView(
        _: UIPickerView,
        numberOfRowsInComponent _: Int
    ) -> Int {
        return MathTransformation.allCases.count
    }
}

// MARK: - UIPickerview delegate conformance

extension EvaluatorViewController: UIPickerViewDelegate {
    func pickerView(
        _: UIPickerView,
        didSelectRow row: Int,
        inComponent _: Int
    ) {
        let transformation = MathTransformation.allCases[row]
        viewModel.updateTransformation(transformation)
        transformationTextField.text = transformation.name
    }

    func pickerView(
        _: UIPickerView,
        titleForRow row: Int,
        forComponent _: Int
    ) -> String? {
        return MathTransformation.allCases[row].name
    }
}

// MARK: - UITextField delegate conformance

extension EvaluatorViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let text = textField.text else { return true }
        evaluateButton.isEnabled = !NSString(string: text).replacingCharacters(in: range, with: string).isEmpty
        return true
    }

    func textFieldShouldBeginEditing(_: UITextField) -> Bool {
        return true
    }

    func textFieldShouldClear(_: UITextField) -> Bool {
        return true
    }

    func textFieldShouldReturn(_: UITextField) -> Bool {
        return true
    }
}

// MARK: - Private API

private extension EvaluatorViewController {
    @IBAction func evaluateExpression() {
        view.endEditing(true)
        viewModel.updateExpression(expressionTextField.text)
        viewModel.evaluateExpression()
    }

    @IBAction func dismissKeyboard(_: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
