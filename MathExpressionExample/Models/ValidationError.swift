//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

struct ValidationError: Error {
    let description: String

    init(_ description: String) {
        self.description = description
    }
}
