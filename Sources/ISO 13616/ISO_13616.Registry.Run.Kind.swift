extension ISO_13616.Registry.Run {
    internal enum Kind: Sendable {
        case digits
        case letters
        case alphanumerics
    }
}

extension ISO_13616.Registry.Run.Kind {
    internal func admits(_ byte: UInt8) -> Bool {
        let digit = (UInt8(ascii: "0")...UInt8(ascii: "9")).contains(byte)
        let letter = (UInt8(ascii: "A")...UInt8(ascii: "Z")).contains(byte)
        switch self {
        case .digits:
            return digit

        case .letters:
            return letter

        case .alphanumerics:
            return digit || letter
        }
    }
}
