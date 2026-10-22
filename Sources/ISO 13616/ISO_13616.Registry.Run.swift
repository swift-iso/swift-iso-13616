extension ISO_13616.Registry {

    /// A fixed-length run of characters of one kind in a BBAN structure.
    internal struct Run: Sendable {

        internal let count: Int

        internal let kind: Kind

        internal init(_ count: Int, _ kind: Kind) {
            self.count = count
            self.kind = kind
        }
    }
}
