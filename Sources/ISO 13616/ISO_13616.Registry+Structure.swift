extension ISO_13616.Registry {
    internal static func length(of structure: [ISO_13616.Registry.Run]) -> Int {
        structure.map(\.count).reduce(0, +)
    }

    internal static func matches(_ bban: Substring, _ structure: [ISO_13616.Registry.Run]) -> Bool {
        var bytes = bban.utf8[...]
        for run in structure {
            let segment = bytes.prefix(run.count)
            guard segment.count == run.count, segment.allSatisfy(run.kind.admits) else {
                return false
            }
            bytes = bytes.dropFirst(run.count)
        }
        return bytes.isEmpty
    }
}
