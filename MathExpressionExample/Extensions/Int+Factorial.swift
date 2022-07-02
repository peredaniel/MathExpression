//  Copyright © 2022 Pedro Daniel Prieto Martínez. Distributed under MIT License.

extension Int {
    func factorial() -> Int {
        guard self > 1 else { return 1 }
        return self * (self - 1).factorial()
    }
}
