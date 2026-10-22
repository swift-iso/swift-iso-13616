extension ISO_13616.Registry {
    internal struct Run: Sendable {
        internal let count: Int

        internal let kind: ISO_13616.Registry.Run.Kind

        internal init(_ count: Int, _ kind: ISO_13616.Registry.Run.Kind) {
            self.count = count
            self.kind = kind
        }
    }
}
