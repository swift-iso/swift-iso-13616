extension ISO_13616.IBAN {
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
