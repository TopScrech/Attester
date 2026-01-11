#if (os(macOS) || os(iOS) || os(watchOS) || os(tvOS)) && CRYPTO_IN_SWIFTPM && !CRYPTO_IN_SWIFTPM_FORCE_BUILD_API
@_exported import CryptoKit
#else
import Foundation

extension ASN1 {
    /// An octet string is a representation of a string of octets.
    struct ASN1OctetString: ASN1Parseable, ASN1Serializable {
        var bytes: ArraySlice<UInt8>
        
        init(asn1Encoded node: ASN1.ASN1Node) throws {
            guard node.identifier == .primitiveOctetString else {
                throw CryptoKitASN1Error.unexpectedFieldType
            }
            
            guard case .primitive(let content) = node.content else {
                preconditionFailure("ASN.1 parser generated primitive node with constructed content")
            }
            
            self.bytes = content
        }
        
        init(contentBytes: ArraySlice<UInt8>) {
            self.bytes = contentBytes
        }
        
        func serialize(into coder: inout ASN1.Serializer) throws {
            coder.appendPrimitiveNode(identifier: .primitiveOctetString) { bytes in
                bytes.append(contentsOf: self.bytes)
            }
        }
    }
}

extension ASN1.ASN1OctetString: Hashable {}

extension ASN1.ASN1OctetString: ContiguousBytes {
    func withUnsafeBytes<R>(_ body: (UnsafeRawBufferPointer) throws -> R) rethrows -> R {
        try self.bytes.withUnsafeBytes(body)
    }
}

#endif // Linux or !SwiftPM
