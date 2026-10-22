import ISO_7064

extension ISO_13616.IBAN {
    public init(_ text: some StringProtocol) throws(ISO_13616.IBAN.Error) {
        let value = try Self.electronic(text)
        let country = String(value.prefix(2))
        guard let structure = ISO_13616.Registry.bban[country] else {
            throw .unregisteredCountry(country)
        }
        let length = 4 + ISO_13616.Registry.length(of: structure)
        guard value.utf8.count == length else {
            throw .invalidLength(country: country, expected: length, found: value.utf8.count)
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
    private static func electronic(
        _ text: some StringProtocol
    ) throws(ISO_13616.IBAN.Error) -> String {
        for byte in text.utf8 {
            switch byte {
            case UInt8(ascii: "A")...UInt8(ascii: "Z"), UInt8(ascii: "0")...UInt8(ascii: "9"), UInt8(ascii: " "):
                continue

            default:
                throw .invalidCharacter
            }
        }
        let groups = text.split(separator: " ", omittingEmptySubsequences: false)
        guard groups.count == 1 || Self.isPaper(groups) else {
            throw .invalidGrouping
        }
        return groups.joined()
    }

    private static func isPaper(_ groups: [some StringProtocol]) -> Bool {
        groups.dropLast().allSatisfy { $0.utf8.count == 4 }
            && (1...4).contains(groups.last?.utf8.count ?? 0)
    }
}
