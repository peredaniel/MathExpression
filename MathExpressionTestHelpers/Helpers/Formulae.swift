//  Copyright © 2019 Pedro Daniel Prieto Martínez. Distributed under MIT License.

enum Formula {
    enum AbelianAdditiveGroupAxiomsTests {
        static let neutralElement = "%d + %d"
        static let inverseElement = "- %d"
        static let leftInverse = "- %d + %d"
        static let rightInverse = "%d + (- %d)"
        static let leftAssociativity = "(%d + %d) + %d"
        static let rightAssociativity = "%d + (%d + %d)"
        static let commutativity = "%d + %d"
    }

    enum AbelianMultiplicativeGroupAxiomTests {
        static let neutralElement = "%d * %d"
        static let inverseElement = "1 / %d"
        static let leftInverse = "(1 / %d) * %d"
        static let rightInverse = "%d * (1 / %d)"
        static let leftAssociativity = "(%d * %d) * %d"
        static let rightAssociativity = "%d * (%d * %d)"
        static let commutativity = "%d * %d"
    }

    enum AdditionAndSubtractionTests {
        static let simpleOperation = "%d - %d + %d"
        static let simpleOperationWithParentheses = "%d - (-%d + %d)"
        static let simpleOperationWithParenthesesAndInitialMinus = "- (%d - %d) - %d + %d"
    }

    enum AdditionTests {
        static let simpleAddition = "%d + %d"
        static let complicatedAddition = "%d + %d + %d + %d"
        static let simpleAdditionWithParentheses = "(%d + %d)"
        static let complicatedAdditionWithSingleParenthesis = "%d + (%d + %d) + %d"
        static let complicatedAdditionWithMultipleParenthesis = "(%d + %d) + %d + ((%d + %d) + %d)"
    }

    enum CombinedOperationsTests {
        static let productOfAddition = "(%d + %d) * (%d + %d)"
        static let productOfSubtraction = "(%d - %d) * (%d - %d)"
        static let productOfAdditionWithSubtraction = "(%d + %d) * (%d - %d)"
        static let divisionOfAdditionWithSubtraction = "(%d + %d) / (%d - %d)"
        static let divisionOfProductOfAdditionsWithProductOfSubtractions = "(%d + %d) * (%d + %d) / ((%d - %d) * (%d - %d))"
        static let divisionOfCrossedProducts = "(%d + %d) * (%d - %d) / ((%d + %d) * (%d - %d))"
    }

    enum DivisionTests {
        static let simpleDivision = "%d / %d"
        static let simpleDivisionWithParentheses = "(%d / %d)"
        static let simpleDivisionWithParenthesesWithInitialDivision = "1 / (%d / %d)"
        static let complicatedDivision = "%d / %d / %d"
        static let divideSingleNumber = "1 / %d"
        static let consecutiveDivisionExpressionWithInitialDivision = "1 / %d / %d / %d"
    }

    enum FieldAxiomTests {
        static let leftDistributivityFactored = "%d * (%d + %d)"
        static let rightDistributivityFactored = "(%d + %d) * %d"
        static let distributivityExpanded = "(%d * %d) + (%d * %d)"
    }

    enum ProductAndDivisionTests {
        static let simpleOperation = "%d / %d * %d"
        static let simpleOperationWithParentheses = "%d / (1 / %d * %d)"
        static let simpleOperationWithParenthesesAndInitialDivision = "1 / (%d / %d) / %d * %d"
        static let complicatedOperationWithParentheses = "(1 / %d * (%d / %d) * %d) / (%d * %d)"
    }

    enum ProductTests {
        static let simpleProduct = "%d * %d"
        static let complicatedProduct = "%d * %d * %d * %d"
        static let simpleProductWithParentheses = "(%d * %d)"
        static let complicatedProductWithSingleParenthesis = "%d * (%d * %d) * %d"
        static let complicatedProductWithMultipleParenthesis = "(%d * %d) * (%d * %d)"
    }

    enum SubtractionTests {
        static let simpleSubtraction = "%d - %d"
        static let simpleSubtractionWithParentheses = "(%d - %d)"
        static let simpleSubtractionWithParenthesesWithInitialMinus = "- (%d - %d)"
        static let complicatedSubtraction = "%d - %d - %d"
        static let negativeSingleNumber = "- %d"
        static let negativeExpressionWithInitialMinus = "- %d - %d - %d"
    }

    enum TransformationTests {
        static let productOfAddition = "(%d + %@) * (%d + %@)"
        static let productOfSubtraction = "(%d - %@) * (%d - %@)"
        static let productOfAdditionWithSubtraction = "(%d + %@) * (%d - %@)"
        static let divisionOfAdditionWithSubtraction = "(%d + %@) / (%d - %@)"
        static let divisionOfProductOfAdditionsWithProductOfSubtractions = "(%d + %@) * (%d + %@) / ((%d - %@) * (%d - %@))"
        static let divisionOfCrossedProducts = "(%d + %@) * (%d - %@) / ((%d + %@) * (%d - %@))"
    }

    enum ValidationTests {
        enum Invalid {
            static let unevenBracketNumber = "(%d + %d) * %d / %d - %d)"
            static let misplacedBrackets = ")%d) + %d) * (%d / (%d - %d)"
            static let misplacedSumAndClosingBracket = "(%d + %d +) * (%d / (%d - %d))"
            static let misplacedSubtractionAndClosingBracket = "(%d + %d -) * (%d / (%d - %d))"
            static let misplacedProductAndClosingBracket = "(%d + %d *) * (%d / (%d - %d))"
            static let misplacedDivisionAndClosingBracket = "(%d + %d /) * (%d / (%d - %d))"
            static let misplacedOpeningBracketAndProduct = "(%d + %d) * (%d / (* %d - %d))"
            static let misplacedOpeningBracketAndDivision = "(%d + %d) * (%d / (/ %d - %d))"
            static let productFollowedByDivision = "(%d + %d) * / (%d / (%d - %d))"
            static let divisionFollowedByProduct = "(%d + %d) / * (%d / (%d - %d))"
            static let consecutiveProducts = "(%d + %d) * * (%d / (%d - %d))"
            static let consecutiveDivisions = "(%d + %d) / / (%d / (%d - %d))"
            static let sumFollowedByProduct = "(%d + %d) + * (%d / (%d - %d))"
            static let sumFollowedByDivision = "(%d + %d) + / (%d / (%d - %d))"
            static let subtractionFollowedByProduct = "(%d + %d) - * (%d / (%d - %d))"
            static let subtractionFollowedByDivision = "(%d + %d) - / (%d / (%d - %d))"
            static let startsWithProduct = "* (%d + %d) / (%d / (%d - %d))"
            static let startsWithDivision = "/ (%d + %d) * (%d / (%d - %d))"
            static let endsWithSum = "(%d + %d) * (%d / (%d - %d)) +"
            static let endsWithSubtraction = "(%d + %d) * (%d / (%d - %d)) -"
            static let endsWithProduct = "(%d + %d) * (%d / (%d - %d)) *"
            static let endsWithDivision = "(%d + %d) * (%d / (%d - %d)) /"
        }

        enum Valid {
            static let generic = "(%d + %d) * (%d / (%d - %d))"
            static let consecutiveSubtractions = "(%d - - %d) * (%d / (%d - %d))"
            static let consecutiveSums = "(%d + + %d) * (%d / (%d - %d))"
            static let consecutiveSumAndSubtraction = "(%d + %d) * (%d / (%d + - %d))"
            static let consecutiveSubtractionAndSum = "(%d + %d) * (%d / (%d - + %d))"
        }
    }
}
