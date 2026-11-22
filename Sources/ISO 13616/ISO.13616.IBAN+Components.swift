extension ISO.`13616`.IBAN {
    // swift-linter:disable:next raw concept
    // REASON: the IBAN registry holds XK, which ISO_3166.Alpha2 refuses as it is not in ISO 3166-1, so this can't be ISO_3166.Alpha2 or ISO_3166.Code without losing valid IBANs
    public var country: Substring {
        value.prefix(2)
    }

    public var check: Substring {
        value.dropFirst(2).prefix(2)
    }

    public var bban: Substring {
        value.dropFirst(4)
    }

    public var paper: String {
        stride(from: 0, to: value.utf8.count, by: 4)
            .map { offset in String(value.dropFirst(offset).prefix(4)) }
            .joined(separator: " ")
    }
}
