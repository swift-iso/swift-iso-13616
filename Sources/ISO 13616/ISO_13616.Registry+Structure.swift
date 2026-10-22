extension ISO_13616.Registry {

    /// The length of a BBAN with `structure`.
    internal static func length(of structure: [Run]) -> Int {
        structure.map(\.count).reduce(0, +)
    }

    /// Whether `bban` consists of exactly the runs of `structure`.
    internal static func matches(_ bban: Substring, _ structure: [Run]) -> Bool {
        var scalars = bban.unicodeScalars[...]
        for run in structure {
            let segment = scalars.prefix(run.count)
            guard segment.count == run.count, segment.allSatisfy(run.kind.admits) else {
                return false
            }
            scalars = scalars.dropFirst(run.count)
        }
        return scalars.isEmpty
    }
}
