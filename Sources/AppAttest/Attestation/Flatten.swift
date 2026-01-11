protocol Node {
    associatedtype S: Sequence where S.Element == Self
    var children: S { get }
}

extension Node {
    var flatten: [Self] {
        [self] + children.flatMap { $0.flatten }
    }
}

extension ASN1.ASN1Node: Node {
    var children: [ASN1.ASN1Node] {
        switch self.content {
        case let .constructed(nodes):
            Array(nodes)
            
            // Inefficient. Construct an empty ASN1.ASN1NodeCollection instead.
        case .primitive(_):
            []
        }
    }
}
