import ISO_7064

extension ISO_13616.IBAN {

    /// Validates `text` as an IBAN in electronic format (`NL91ABNA0417164300`)
    /// or paper format (`NL91 ABNA 0417 1643 00`).
    public init(_ text: some StringProtocol) throws(Error) {
        let value = try Self.electronic(text)
        let country = String(value.prefix(2))
        guard let structure = ISO_13616.Registry.bban[country] else {
            throw .unregisteredCountry(country)
        }
        let length = 4 + ISO_13616.Registry.length(of: structure)
        guard value.count == length else {
            throw .invalidLength(country: country, expected: length, found: value.count)
        }
        let check = value.dropFirst(2).prefix(2)
        guard let digits = Int(check), (2...98).contains(digits) else {
            throw .invalidCheckDigits(String(check))
        }
        guard ISO_13616.Registry.matches(value.dropFirst(4), structure) else {
            throw .invalidStructure
        }
        guard ISO_7064.MOD_97_10.isValid(value.dropFirst(4) + value.prefix(4)) else {
            throw .invalidChecksum
        }
        self.value = value
    }
}

extension ISO_13616.IBAN {

    /// The electronic format of `text`: its characters with the paper-format
    /// spaces removed.
    private static func electronic(_ text: some StringProtocol) throws(Error) -> String {
        for scalar in text.unicodeScalars {
            switch scalar {
            case "A"..."Z", "0"..."9", " ":
                continue
            default:
                throw .invalidCharacter(scalar)
            }
        }
        let groups = text.split(separator: " ", omittingEmptySubsequences: false)
        guard groups.count == 1 || (groups.dropLast().allSatisfy { $0.count == 4 } && (1...4).contains(groups.last!.count)) else {
            throw .invalidGrouping
        }
        return groups.joined()
    }
}
