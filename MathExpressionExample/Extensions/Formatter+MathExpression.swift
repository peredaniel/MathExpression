//  Copyright © 2022 Pedro Daniel Prieto Martínez. Distributed under MIT License.

import Foundation

extension Formatter {
    static let mathExpression: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 6
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = "."
        formatter.usesGroupingSeparator = false
        return formatter
    }()
}
