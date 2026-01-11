#if (os(macOS) || os(iOS) || os(watchOS) || os(tvOS)) && CRYPTO_IN_SWIFTPM && !CRYPTO_IN_SWIFTPM_FORCE_BUILD_API
@_exported import CryptoKit
#else
import Foundation

extension ASN1 {
    /// An `ASN1Identifier` is a representation of the abstract notion of an ASN.1 identifier. Identifiers have a number of properties that relate to both the specific
    /// tag number as well as the properties of the identifier in the stream.
    internal struct ASN1Identifier {
        /// The base tag. In a general ASN.1 implementation we'd need an arbitrary precision integer here as the tag number can be arbitrarily large, but
        /// we don't need the full generality here.
        private(set) var baseTag: UInt8
        
        /// Whether this tag is primitive.
        var primitive: Bool {
            self.baseTag & 0x20 == 0
        }
        
        /// Whether this tag is constructed.
        var constructed: Bool {
            !self.primitive
        }
        
        enum TagClass {
            case universal,
                 application,
                 contextSpecific,
                 `private`
        }
        
        /// The class of this tag.
        var tagClass: TagClass {
            switch self.baseTag >> 6 {
            case 0x00: .universal
            case 0x01: .application
            case 0x02: .contextSpecific
            case 0x03: .private
            default: fatalError("Unreachable")
            }
        }
        
        init(rawIdentifier: UInt8) throws {
            // We don't support multibyte identifiers, which are signalled when the bottom 5 bits are all 1.
            guard rawIdentifier & 0x1F != 0x1F else {
                throw CryptoKitASN1Error.invalidFieldIdentifier
            }
            
            self.baseTag = rawIdentifier
        }
        
        init(explicitTagWithNumber number: Int, tagClass: TagClass) {
            precondition(number >= 0)
            precondition(number < 0x1F)
            
            self.baseTag = UInt8(number)
            
            switch tagClass {
            case .universal:
                preconditionFailure("Explicit tags may not be universal")
                
            case .application:
                self.baseTag |= 1 << 6
                
            case .contextSpecific:
                self.baseTag |= 2 << 6
                
            case .private:
                self.baseTag |= 3 << 6
            }
            
            // Explicit tags are always constructed.
            self.baseTag |= 0x20
        }
    }
}

extension ASN1.ASN1Identifier {
    internal static let objectIdentifier = try! ASN1.ASN1Identifier(rawIdentifier: 0x06)
    internal static let primitiveBitString = try! ASN1.ASN1Identifier(rawIdentifier: 0x03)
    internal static let primitiveOctetString = try! ASN1.ASN1Identifier(rawIdentifier: 0x04)
    internal static let integer = try! ASN1.ASN1Identifier(rawIdentifier: 0x02)
    internal static let sequence = try! ASN1.ASN1Identifier(rawIdentifier: 0x30)
}

extension ASN1.ASN1Identifier: Hashable {}

extension ASN1.ASN1Identifier: CustomStringConvertible {
    var description: String {
        "ASN1Identifier(\(self.baseTag))"
    }
}

#endif // Linux or !SwiftPM
