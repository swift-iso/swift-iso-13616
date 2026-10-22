extension ISO_13616 {

    /// An international bank account number that satisfies ISO 13616-1.
    ///
    /// An IBAN is a registered two-letter country code, two check digits, and
    /// a basic bank account number (BBAN) with the structure the ISO 13616-2
    /// registry fixes for that country, and its check digits satisfy
    /// ISO 7064 MOD 97-10.
    ///
    /// The only way to obtain a value is the validating initializer, so every
    /// value is a well-formed IBAN. A well-formed IBAN is not necessarily an
    /// account that exists.
    public struct IBAN: Sendable, Hashable {

        /// The IBAN in electronic format: upper-case letters and digits, no
        /// separators.
        public let value: String
    }
}
