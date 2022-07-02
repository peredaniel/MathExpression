//  Copyright © 2022 Pedro Daniel Prieto Martínez. Distributed under MIT License.

import SwiftUI

struct CalculatorView: View {
    @StateObject var viewModel: CalculatorViewModel = .init()

    var body: some View {
        VStack(alignment: .trailing, spacing: 16) {
            Text(viewModel.expression)
                .font(.headline)
                .padding(.top, 24)
            Text(viewModel.operationResult)
                .font(.largeTitle)
            Spacer()
            CalculatorKeyboardView(
                clearButtonTitle: $viewModel.clearButtonTitle,
                lastKeyTapped: $viewModel.lastKeyTapped
            )
        }
        .padding(.horizontal)
        .padding(.vertical, 24)
        .navigationTitle("Calculator")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Validation error", isPresented: $viewModel.shouldShowError) {
            Button("Ok") {
                viewModel.reset()
            }
        } message: {
            Text(viewModel.operationError?.description ?? "")
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
