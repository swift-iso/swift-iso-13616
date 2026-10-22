extension ISO_13616.IBAN {
    public enum Error: Swift::Error, Sendable, Equatable {
        case invalidCharacter
        case invalidGrouping
        case unregisteredCountry(String)
        case invalidLength(country: String, expected: Int, found: Int)
        case invalidCheckDigits(String)
        case invalidStructure
        case invalidChecksum
    }
}
