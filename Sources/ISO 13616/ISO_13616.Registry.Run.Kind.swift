extension ISO_13616.Registry.Run {

    /// The characters a run admits: `n`, `a`, or `c` in the registry's
    /// notation.
    internal enum Kind: Sendable {
        case digits
        case letters
        case alphanumerics
    }
}

extension ISO_13616.Registry.Run.Kind {

    internal func admits(_ scalar: Unicode.Scalar) -> Bool {
        switch self {
        case .digits: ("0"..."9").contains(scalar)
        case .letters: ("A"..."Z").contains(scalar)
        case .alphanumerics: ("0"..."9").contains(scalar) || ("A"..."Z").contains(scalar)
        }
    }
}
