extension ISO_13616.IBAN {

    /// The registry country code, such as `NL`.
    public var country: Substring {
        value.prefix(2)
    }

    /// The two check digits.
    public var check: Substring {
        value.dropFirst(2).prefix(2)
    }

    /// The basic bank account number that follows the check digits.
    public var bban: Substring {
        value.dropFirst(4)
    }

    /// The IBAN in paper format: groups of four characters separated by
    /// spaces.
    public var paper: String {
        stride(from: 0, to: value.count, by: 4)
            .map { offset in String(value.dropFirst(offset).prefix(4)) }
            .joined(separator: " ")
    }
}
