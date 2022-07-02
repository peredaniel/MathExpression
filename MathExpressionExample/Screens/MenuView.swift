//  Copyright © 2022 Pedro Daniel Prieto Martínez. Distributed under MIT License.

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("The calculator is a simple calculator, similar to the built-in calculator app in iOS, enabling simple mathematical computations to be performed.")
                    .font(.callout)
                    .padding(.horizontal)
                    .multilineTextAlignment(.leading)
                NavigationLink(destination: CalculatorView()) {
                    HStack {
                        Spacer()
                        Text("Go to Calculator!")
                            .foregroundColor(.accentColor)
                        Spacer()
                    }
                }
                Divider()
                    .padding(.horizontal)
                Text("The evaluator enables to compute more complicated expressions, also giving the opportunity to use some pre-built transformations to convert plain String instances to numeric values.")
                    .font(.callout)
                    .padding(.horizontal)
                    .multilineTextAlignment(.leading)
                NavigationLink(destination: EvaluatorView()) {
                    HStack {
                        Spacer()
                        Text("Go to Evaluator!")
                            .foregroundColor(.accentColor)
                        Spacer()
                    }
                }
                Spacer()
            }
            .padding(.top, 8)
            .navigationTitle("Example App")
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
