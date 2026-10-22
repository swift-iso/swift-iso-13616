import Testing

import ISO_13616

extension ISO_13616.IBAN {
    @Suite struct Test {
        @Suite struct Unit {}
        @Suite struct `Edge Case` {}
    }
}

extension ISO_13616.IBAN.Test.Unit {

    @Test(arguments: [
        "GB82WEST12345698765432",
        "NL91ABNA0417164300",
        "DE89370400440532013000",
        "BE68539007547034",
        "NO9386011117947",
        "MT84MALT011000012345MTLCAST001S",
        "LC55HEMM000100010012001200023015",
        "RU0204452560040702810412345678901",
        "XK051212012345678906",
    ])
    func `known-valid IBANs are accepted`(text: String) throws {
        #expect(try ISO_13616.IBAN(text).value == text)
    }

    @Test
    func `the paper format is accepted and normalized to the electronic format`() throws {
        let iban = try ISO_13616.IBAN("NL91 ABNA 0417 1643 00")
        #expect(iban.value == "NL91ABNA0417164300")
        #expect(iban.paper == "NL91 ABNA 0417 1643 00")
    }

    @Test
    func `the components split the electronic format`() throws {
        let iban = try ISO_13616.IBAN("NL91ABNA0417164300")
        #expect(iban.country == "NL")
        #expect(iban.check == "91")
        #expect(iban.bban == "ABNA0417164300")
    }

    @Test
    func `an altered digit fails the checksum`() {
        #expect(throws: ISO_13616.IBAN.Error.invalidChecksum) {
            try ISO_13616.IBAN("GB82WEST12345698765433")
        }
        #expect(throws: ISO_13616.IBAN.Error.invalidChecksum) {
            try ISO_13616.IBAN("NL92ABNA0417164300")
        }
    }

    @Test
    func `transposed digits fail the checksum`() {
        #expect(throws: ISO_13616.IBAN.Error.invalidChecksum) {
            try ISO_13616.IBAN("NL91ABNA0417163400")
        }
    }
}

extension ISO_13616.IBAN.Test.`Edge Case` {

    @Test
    func `a correct checksum at the wrong length is refused`() {
        #expect(throws: ISO_13616.IBAN.Error.invalidLength(country: "NL", expected: 18, found: 17)) {
            try ISO_13616.IBAN("NL58ABNA041716430")
        }
    }

    @Test
    func `a correct checksum for an unregistered country is refused`() {
        #expect(throws: ISO_13616.IBAN.Error.unregisteredCountry("US")) {
            try ISO_13616.IBAN("US07ABNA0417164300")
        }
    }

    @Test
    func `check digits outside 02 to 98 are refused`() {
        #expect(throws: ISO_13616.IBAN.Error.invalidCheckDigits("00")) {
            try ISO_13616.IBAN("NL00ABNA0417164300")
        }
        #expect(throws: ISO_13616.IBAN.Error.invalidCheckDigits("9A")) {
            try ISO_13616.IBAN("NL9AABNA0417164300")
        }
    }

    @Test
    func `check digits 99 are refused even where their MOD 97-10 alias 02 is valid`() {
        #expect(throws: ISO_13616.IBAN.Error.invalidCheckDigits("99")) {
            try ISO_13616.IBAN("NL99ABNA0000000039")
        }
    }

    @Test
    func `a correct checksum over a BBAN of the wrong structure is refused`() {
        #expect(throws: ISO_13616.IBAN.Error.invalidStructure) {
            try ISO_13616.IBAN("NL7112345678901234")
        }
    }

    @Test
    func `lower-case text is refused`() {
        #expect(throws: ISO_13616.IBAN.Error.invalidCharacter("n")) {
            try ISO_13616.IBAN("nl91abna0417164300")
        }
    }

    @Test
    func `spaces that do not form groups of four are refused`() {
        #expect(throws: ISO_13616.IBAN.Error.invalidGrouping) {
            try ISO_13616.IBAN("NL91 ABNA0417 164300")
        }
        #expect(throws: ISO_13616.IBAN.Error.invalidGrouping) {
            try ISO_13616.IBAN("NL91  ABNA 0417 1643 00")
        }
        #expect(throws: ISO_13616.IBAN.Error.invalidGrouping) {
            try ISO_13616.IBAN("NL91 ABNA 0417 1643 00 ")
        }
    }

    @Test
    func `empty text has no registered country`() {
        #expect(throws: ISO_13616.IBAN.Error.unregisteredCountry("")) {
            try ISO_13616.IBAN("")
        }
    }

    @Test
    func `non-ASCII characters are refused`() {
        #expect(throws: ISO_13616.IBAN.Error.invalidCharacter("\u{301}")) {
            try ISO_13616.IBAN("NL91ABNA0417164300\u{301}")
        }
    }
}
