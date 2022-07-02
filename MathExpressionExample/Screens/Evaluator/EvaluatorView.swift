//  Copyright © 2022 Pedro Daniel Prieto Martínez. Distributed under MIT License.

import SwiftUI

struct EvaluatorView: View {
    @StateObject var viewModel: EvaluatorViewModel = .init()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Expression to evaluate")
                    .font(.subheadline)
                ZStack(alignment: .trailing) {
                    TextField("Type in a mathematical expression", text: $viewModel.expression)
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.leading)
                    Button {
                        viewModel.expression = ""
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                    .padding(.trailing, 4)
                    .foregroundColor(.gray)

                }
            }
            Divider()
            VStack(alignment: .leading, spacing: 12) {
                Text("Transformation to apply")
                Picker("", selection: $viewModel.transformation) {
                    ForEach(MathTransformation.allCases, id: \.name) { transformation in
                        Text(transformation.name)
                            .tag(transformation)
                    }
                }
                .pickerStyle(.menu)
            }
            Divider()
            if !viewModel.operationResult.isEmpty {
                Text(viewModel.operationResult)
            }
            HStack {
                Spacer()
                Button("Evaluate expression!") {
                    viewModel.evaluateExpression()
                }
                Spacer()
            }
            Spacer()
        }
        .navigationTitle("Evaluator")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .alert("Validation error", isPresented: $viewModel.shouldShowError) {
            Button("Ok") {
                viewModel.shouldShowError = false
            }
        } message: {
            Text(viewModel.operationError?.description ?? "")
        }
    }
}

struct EvaluatorView_Previews: PreviewProvider {
    static var previews: some View {
        EvaluatorView()
    }
}
