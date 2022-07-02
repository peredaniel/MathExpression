//  Copyright © 2022 Pedro Daniel Prieto Martínez. Distributed under MIT License.

import SwiftUI

struct CalculatorKeyboardView: View {
    @Binding var clearButtonTitle: String
    @Binding var lastKeyTapped: String?

    private var data: [String] {
        [
            clearButtonTitle, "(", ")", "/",
            "7", "8", "9", "*",
            "4", "5", "6", "-",
            "1", "2", "3", "+",
            "0", ".", "+/-", "="
        ]
    }

    private let columns: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible())
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 48) {
            ForEach(data, id: \.self) { item in
                Button {
                    lastKeyTapped = item
                } label: {
                    Text(item)
                        .font(.title)
                }
            }
        }
    }
}

struct CalculatorKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorKeyboardView(clearButtonTitle: .constant("C"), lastKeyTapped: .constant(""))
            .padding(.horizontal, 16)
    }
}

