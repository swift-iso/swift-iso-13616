extension ISO_13616.IBAN {

    public enum Error: Swift.Error, Sendable, Equatable {

        /// The text contains a character other than `A`–`Z`, `0`–`9`, or a
        /// paper-format space.
        case invalidCharacter(Unicode.Scalar)

        /// The spaces do not split the text into groups of four, as the paper
        /// format requires.
        case invalidGrouping

        /// The first two characters are not a country code in the IBAN
        /// registry.
        case unregisteredCountry(String)

        /// The IBAN's length differs from the length the registry fixes for
        /// its country.
        case invalidLength(country: String, expected: Int, found: Int)

        /// The third and fourth characters are not check digits `02`–`98`.
        case invalidCheckDigits(String)

        /// The BBAN does not have the structure the registry fixes for its
        /// country.
        case invalidStructure

        /// The check digits do not satisfy ISO 7064 MOD 97-10.
        case invalidChecksum
    }
}
